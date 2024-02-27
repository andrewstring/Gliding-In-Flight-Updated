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
    
    
    private let imageryMapConfig = MKImageryMapConfiguration()
    let mapView = MKMapView()
    var thermals: [Thermal] = []
    
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
    
    init(navigationModel: NavigationModel, locationModel: LocationModel, barometricModel: BarometricModel, flightStore: FlightStore, gliderStore: GliderStore) {
        self.navigationModel = navigationModel
        self.locationModel = locationModel
        self.barometricModel = barometricModel
        self.flightStore = flightStore
        self.gliderStore = gliderStore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        initMap()
        guard let currentLocation = locationModel.currentLocation else { return }
        print("LATLONG")
        print(currentLocation.latitude)
        print(currentLocation.longitude)
        print("111")
        APIThermal.getThermalByRadius(latitude: currentLocation.latitude, longitude: currentLocation.longitude, callback: addThermalCallback)
    }
    
    func initMap() {
        self.view = mapView
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.showsUserTrackingButton = true
        self.mapView.preferredConfiguration = imageryMapConfig
        
        do {
            try setPreFlight()
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
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: GlidingMapViewConfig.postFlightZoom, longitudinalMeters: GlidingMapViewConfig.postFlightZoom)
        self.mapView.showsCompass = false
        self.mapView.setRegion(region, animated: true)
        
        guard let flight = self.flightStore.flight else { throw GlidingMapViewControllerError.HandlingPostFlightMapStateUpdateWithoutFlightError }
        self.mapView.addOverlay(RouteOverview.generateRouteOverview(locations: flight.locations), level: .aboveLabels)
        if flight.locations.count > 0 {
            self.mapView.setCenter(flight.locations[0].coordLocation, animated: true)
        }
    }
}

// Thermal Annotation Adding/Removing
extension GlidingMapViewController {
    func addThermalAnnotations(thermals: [Thermal]) {
        self.thermals.append(contentsOf: thermals)
        DispatchQueue.main.async {
            self.mapView.addAnnotations(thermals.map({ ThermalAnnotation(thermal: $0) }))
        }
    }
    
    func removeThermalAnnotation(thermals: [Thermal]) {
        self.thermals = self.thermals.filter {
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
