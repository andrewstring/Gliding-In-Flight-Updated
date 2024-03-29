//
//  GlidingMapViewController.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import UIKit
import MapKit

class GlidingMapViewController: UIViewController {
    let navigationModel: NavigationModel
    let locationModel: LocationModel
    let barometricModel: BarometricModel
    let flightStore: FlightStore
    let gliderStore: GliderStore
    var thermalStore: ThermalStore
    
    var socketConnection: SocketConnection? = nil
    
    
    private let imageryMapConfig = MKImageryMapConfiguration()
    let mapView = MKMapView()
    
    var mapState: MapState = .preFlight {
        didSet {
            switch mapState {
            case .preFlight:
                do {
                    try setPreFlight()
                } catch {
                    print(error)
                }
            case .inFlight:
                do {
                    try setInFlight()
                } catch {
                    print(error)
                }
            case .inOverviewFlight:
                do {
                    try setInOverviewFlight()
                } catch {
                    print(error)
                }
            case .postFlight:
                do {
                    try setPostFlight()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    init(navigationModel: NavigationModel, locationModel: LocationModel, barometricModel: BarometricModel, flightStore: FlightStore, gliderStore: GliderStore, thermalStore: ThermalStore) {
        self.navigationModel = navigationModel
        self.locationModel = locationModel
        self.barometricModel = barometricModel
        self.flightStore = flightStore
        self.gliderStore = gliderStore
        self.thermalStore = thermalStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        initMap()
        guard let currentLocation = locationModel.currentLocation else { return }
        APIThermal.getThermalByRadius(latitude: currentLocation.latitude, longitude: currentLocation.longitude, callback: addThermalCallback)
        self.socketConnection = SocketConnection(thermalChangeHandler: addThermalAnnotations)
        
        
        
        self.locationModel.glidingMapViewController = self
    }
    
    func initMap() {
        self.view = mapView
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.showsUserTrackingButton = true
        self.mapView.preferredConfiguration = imageryMapConfig
        
        do {
            try setPreFlight()
            // FOR TESTING//
            let thermalTest = [
                Thermal(Location(CLLocation(latitude: 39.2524, longitude: -84.33))),
                Thermal(Location(CLLocation(latitude: 39.2555,longitude: -84.33)), Glider(id: "JKLJKL", name: "JKLJKL"))
            ]
            addThermalAnnotations(thermals: thermalTest)
            // FOR TESTING//
        } catch {
            print(error)
        }
    }
}


// Flight state logic
extension GlidingMapViewController {
    
    func setPreFlight() throws {
        self.mapView.removeOverlays(self.mapView.overlays)
        
        guard let location = self.locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.preFlightZoom, longitudinalMeters: GlidingMapViewConfig.preFlightZoom)
        self.mapView.setRegion(region, animated: true)
    }
    
    func setInFlight() throws {
        self.mapView.removeOverlays(self.mapView.overlays)
        
        guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.inFlightZoom, longitudinalMeters: GlidingMapViewConfig.inFlightZoom)
        self.mapView.showsCompass = true
        self.mapView.setRegion(region, animated: true)
        self.mapView.setUserTrackingMode(.followWithHeading, animated: true)
    }
    
    
    // IN DEVELOPMENT
    func setInOverviewFlight() throws {
        self.mapView.removeOverlays(self.mapView.overlays)
        
        guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.inOverviewFlightZoom, longitudinalMeters: GlidingMapViewConfig.inOverviewFlightZoom)
        self.mapView.showsCompass = true
        self.mapView.setRegion(region, animated: true)
    }
    
    func setPostFlight() throws {
        guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        var region = flightStore.flight?.getRouteOverviewRegion()
        if region == nil {
            region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.postFlightZoom, longitudinalMeters: GlidingMapViewConfig.postFlightZoom)
        }
        self.mapView.showsCompass = false
        
        guard let flight = self.flightStore.flight else { throw GlidingMapViewControllerError.HandlingPostFlightMapStateUpdateWithoutFlightError }
        self.mapView.addOverlay(RouteOverview.generateRouteOverview(locations: flight.locations), level: .aboveLabels)
//        if flight.locations.count > 0 {
//            self.mapView.setCenter(flight.locations[0].coordLocation, animated: true)
//        }
        self.mapView.setRegion(region!, animated: true)
    }
    
    func setNavigateTo(thermalAnnotationView: ThermalAnnotationView) {
        if let activeThermalAnnotationView = self.thermalStore.activeThermalAnnotationView {
            activeThermalAnnotationView.deactivateIcon()
        }
        thermalStore.activeThermalAnnotationView = thermalAnnotationView
        thermalAnnotationView.activateIcon()
        
        guard let currentCoord = self.locationModel.currentLocation?.coordLocation else { return }
        self.mapView.setCenter(currentCoord, animated: true)
    }
    
    func reCenter(_ mapState: MapState) throws {
        switch mapState {
        case .inFlight:
            self.mapView.setUserTrackingMode(.followWithHeading, animated: true)
        case .inOverviewFlight:
            guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
            let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.inOverviewFlightZoom, longitudinalMeters: GlidingMapViewConfig.inOverviewFlightZoom)
            self.mapView.setRegion(region, animated: true)
        default:
            return
        }
    }
}

// Thermal Annotation Adding/Removing
extension GlidingMapViewController {
    func addThermalAnnotations(thermals: [Thermal]) {
        self.thermalStore.thermals.append(contentsOf: thermals)
        DispatchQueue.main.async {
            self.mapView.addAnnotations(thermals.map({
                if let glider = $0.glider, let gliderStoreGlider = self.gliderStore.glider {
                    print("JKLJKL")
                    print(glider.id)
                    print(gliderStoreGlider.id)
                    print(gliderStoreGlider)
                    return ThermalAnnotation(
                        thermal: $0,
                        userType: glider.id == gliderStoreGlider.id ? .ownUser : .otherUser
                    )
                }
                return ThermalAnnotation(thermal: $0, userType: .ownUser)
            }))
        }
    }
    
    func removeThermalAnnotation(thermals: [Thermal]) {
        self.thermalStore.thermals = self.thermalStore.thermals.filter {
            element in thermals.contains {
                thermal in
                return thermal.id == element.id
            }
        }
        
        let ids = thermals.map { $0.id }
        var annotationsToRemove: [ThermalAnnotation] = []
        for annotation in self.mapView.annotations {
            let thermalAnnotation = annotation as? ThermalAnnotation
            if thermalAnnotation != nil {
                if ids.contains(thermalAnnotation!.id) {
                    annotationsToRemove.append(thermalAnnotation!)
                }
            }
        }
        self.mapView.removeAnnotations(annotationsToRemove)
    }
    
    func addThermalCallback(data: Any) {
        guard let thermalMultiResponse = data as? ThermalMultiResponse else { return }
        addThermalAnnotations(thermals: thermalMultiResponse.data)
    }
}
