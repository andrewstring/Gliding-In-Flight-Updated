//
//  NavigationZoomLevel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 4/4/24.
//

import MapKit

struct NavigationZoomLevel {
    static func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
    
    static func setNavigationZoomLevel(activeThermal: Thermal, centerCoord: CLLocationCoordinate2D) -> MKCoordinateRegion? {
        let width = getScreenSize().width
        do {
            let distance = try activeThermal.location.distance(newLocation: CLLocation(latitude: centerCoord.latitude, longitude: centerCoord.longitude))
            let latitudinalMeters = (distance * 2) + 1000
            let longitudinalMeters = latitudinalMeters
            
            return MKCoordinateRegion(
                center: centerCoord,
                latitudinalMeters: latitudinalMeters,
                longitudinalMeters: longitudinalMeters
            )
            
        } catch {
            return nil
        }
    }
}
