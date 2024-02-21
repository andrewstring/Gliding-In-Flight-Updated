//
//  LocationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class LocationModel: NSObject, ObservableObject {
    @Published var currentLocation: Location?
    @Published var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
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
        if self.currentLocation == nil {
            self.currentLocation = Location(location)
        } else {
            do {
                if try self.currentLocation!.exceedsThresholdDistance(newLocation: location) {
                    self.currentLocation = Location(location)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // Helper func
    func getLatestLocation(_ locations: [CLLocation]) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        return locations.last
    }
}
