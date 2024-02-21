//
//  LocationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class LocationModel: NSObject, ObservableObject {
    @Published var currentLocation: CLLocation?
    
    @Published var navigationModel: NavigationModel? = nil
    var mapState: MapState = .preFlight
    var locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        self.locationManager.activityType = ServicesConfig.activityType
        
        super.init()
    }
}

// Location Manager Delegate
extension LocationModel: CLLocationManagerDelegate {
    
    // Ensure that auth status is always authorized. If not, request for it
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard self.navigationModel == nil else { print("ERROR: NO Navigation Model"); return }
        self.navigationModel!.locationAuthorizationStatus = self.locationManager.authorizationStatus
        if self.locationManager.authorizationStatus != .authorizedAlways {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let navigationModel = self.navigationModel else { print("ERROR: No Location Model"); return }
        guard let location = getLatestLocation(locations) else { return }
        self.currentLocation = location
        do {
            try navigationModel.addNewLocationToFlight(newLocation: location)
        } catch {
            print(error.localizedDescription)
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
