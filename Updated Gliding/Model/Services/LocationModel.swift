//
//  LocationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class LocationModel: NSObject, ObservableObject {
    @Published var currentLocation: Location?
    @Published var locationAuthorizationStatus: CLAuthorizationStatus
    var flightStore: FlightStore?
    
    var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        self.locationAuthorizationStatus = self.locationManager.authorizationStatus
        self.locationManager.activityType = ServicesConfig.activityType
        
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
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
        do {
            if flight.locations.count < 1 {
                print("ADDING ON 0")
                try flight.addNewLocationToFlight(newLocation: Location(location))
            } else {
                let lastLocation = flight.locations[flight.locations.count-1]
                print("LAST")
                print(lastLocation)
                if try lastLocation.exceedsThresholdDistance(newLocation: location) {
                    print("EXCEEDED")
                    try flight.addNewLocationToFlight(newLocation: Location(location))
                }
            }
        } catch {
            print(error.localizedDescription)
        }
//        if self.currentLocation == nil {
//            self.currentLocation = Location(location)
//        } else {
//              if try self.currentLocation!.exceedsThresholdDistance(newLocation: location) {
//            if self.currentLocation != nil {
//                self.currentLocation = Location(location)
//                guard let flight = self.flightStore?.flight else { return }
//                do {
//                    print("ADDING NEW LOCATION")
//                    try flight.addNewLocationToFlight(newLocation: self.currentLocation!)
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
    
    // Helper func
    func getLatestLocation(_ locations: [CLLocation]) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        return locations.last
    }
}
