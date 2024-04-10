//
//  LocationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class LocationModel: NSObject, ObservableObject {
    @Published var currentLocation: Location?
    @Published var currentHeadingFromThermal: Double?
    @Published var currentAltitudeFromThermal: Double?
    @Published var locationAuthorizationStatus: CLAuthorizationStatus
    var locationUpdateRefresher = 0
    var flightStore: FlightStore?
    var thermalStore: ThermalStore?
    var glidingMapViewController: GlidingMapViewController?
    
    var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        self.locationAuthorizationStatus = self.locationManager.authorizationStatus
        self.locationManager.activityType = ServicesConfig.activityType
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.startUpdatingHeading()
    }
    
    func requestLocation() {
        self.locationManager.requestAlwaysAuthorization()
    }
}

// Location Manager Delegate
extension LocationModel: CLLocationManagerDelegate {
    
    // Ensure that auth status is always authorized. If not, request for it
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.locationAuthorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = getLatestLocation(locations) else { return }
        self.currentLocation = Location(location)
        guard let flight = self.flightStore?.flight else { return }
        
        if let activeThermal = thermalStore?.activeThermal {
            self.currentAltitudeFromThermal = activeThermal.location.altitude - location.altitude
        }
        
        do {
            if flight.locations.count < 1 {
                try flight.addNewLocationToFlight(newLocation: Location(location))
            } else {
                let newLocation = Location(location)
                let lastLocation = flight.locations[flight.locations.count-1]
                let distance = try lastLocation.distance(newLocation: location)
                if try Location.exceedsThresholdDistance(distance: distance) {
                    locationUpdateRefresher += 1
                    if locationUpdateRefresher >= 5 {
                        if glidingMapViewController?.mapState == .inFlight && thermalStore?.activeThermal != nil {
                            print("Screen Size")
                            print(NavigationZoomLevel.getScreenSize())
                        }
                        locationUpdateRefresher = 0
                    }
                    try flight.addNewLocationToFlight(newLocation: newLocation)
                    flight.distanceTraveled += distance
                    if self.glidingMapViewController != nil {
                        self.glidingMapViewController!.mapView.addOverlay(RouteOverview.generateRouteOverview(locations: flight.locations), level: .aboveLabels)
                    }
                }
                
                if try lastLocation.exceedsThresholdAltitudePerTimeDelta(newLocation: newLocation) {
                    if var thermals = flightStore?.flight?.thermals {
                        for thermal in thermals {
                            if try thermal.exceedsThresholdDistance(newLocation: newLocation) {
                                thermals.append(Thermal(newLocation))
                                guard let glider = flightStore?.flight?.glider else {
                                    try APIThermal.addThermal(thermalData: Thermal(newLocation))
                                    return
                                }
                                try APIThermal.addThermal(thermalData: Thermal(newLocation, glider))
                                break
                            }
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        var currentHeadingFromThermal: Double? = nil
        guard let thermalCoordinates = thermalStore?.activeThermalAnnotationView?.annotation?.coordinate else {
            self.currentHeadingFromThermal = currentHeadingFromThermal
            return
        }
        guard let currentLocationCoordinates = self.currentLocation?.coordLocation else {
            self.currentHeadingFromThermal = currentHeadingFromThermal
            return
        }
        currentHeadingFromThermal = DirectionalComputation.getHeadingDifference(thermalCoordinates: thermalCoordinates, currentLocationCoordinates: currentLocationCoordinates, heading: newHeading)
        self.currentHeadingFromThermal = currentHeadingFromThermal
    }
    
    // Helper func
    func getLatestLocation(_ locations: [CLLocation]) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        return locations.last
    }
}
