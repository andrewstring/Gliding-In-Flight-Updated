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
            case .postFlight:
                do {
                    try setPostFlight()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    init(navigationModel: NavigationModel, locationModel: LocationModel) {
        self.navigationModel = navigationModel
        self.locationModel = locationModel
        super.init(nibName: nil, bundle: nil)
        print("LOCATION")
        print(locationModel.currentLocation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        initMap()
    }
    
    func initMap() {
        self.view = mapView
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
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
        guard let location = self.locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: 10000.0, longitudinalMeters: 10000.0)
        self.mapView.showsCompass = false
        self.mapView.setRegion(region, animated: true)
    }
    
    func setInFlight() throws {
        guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: 3000.0, longitudinalMeters: 3000.0)
        self.mapView.showsCompass = true
        self.mapView.setRegion(region, animated: true)
    }
    
    func setPostFlight() throws {
        guard let location = locationModel.currentLocation else { throw GlidingMapViewControllerError.HandlingMapStateUpdateWithoutLocationError }
        let region = MKCoordinateRegion(center: location.coordLocation, latitudinalMeters: 6000.0, longitudinalMeters: 6000.0)
        self.mapView.showsCompass = false
        self.mapView.setRegion(region, animated: true)
        
        guard let flight = self.navigationModel.flight else { throw GlidingMapViewControllerError.HandlingPostFlightMapStateUpdateWithoutFlightError }
        self.mapView.addOverlay(RouteOverview.generateRouteOverview(locations: flight.locations), level: .aboveLabels)
        self.mapView.setCenter(flight.locations[0].coordLocation, animated: true)
    }
}

// Thermal Annotation Adding/Removing
extension GlidingMapViewController {
    func addThermalAnnotations(thermals: [Thermal]) {
        self.thermals.append(contentsOf: thermals)
        self.mapView.addAnnotations(thermals.map({ ThermalAnnotation(thermal: $0) }))
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
}
