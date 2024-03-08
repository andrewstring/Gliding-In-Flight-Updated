//
//  Flight+RouteOverview.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/3/24.
//

import MapKit

extension Flight {
    func getRouteOverviewRegion() -> MKCoordinateRegion? {
        guard let minLatitude = self.minLatitude else { return nil }
        guard let maxLatitude = self.maxLatitude else { return nil }
        guard let minLongitude = self.minLongitude else { return nil }
        guard let maxLongitude = self.maxLongitude else { return nil }
        
        let midLatitude = (minLatitude + maxLatitude) / 2.0
        let midLongitude = (minLongitude + maxLongitude) / 2.0
        let center = CLLocationCoordinate2D(latitude: midLatitude, longitude: midLongitude)
        
        let latitudinalRange = maxLatitude - minLatitude
        let latitudinalMeters = MeterConversion.latitudinalDistanceToMeters(latitudinalRange: latitudinalRange) + 100
        
        let longitudinalRange = maxLongitude - minLongitude
        let longitudinalMeters = MeterConversion.longitudinalDistanceToMeters(longitudinalRange: longitudinalRange, minLatitude: minLatitude, maxLatitude: minLongitude) + 100

        return MKCoordinateRegion(
            center: center,
            latitudinalMeters: latitudinalMeters,
            longitudinalMeters: longitudinalMeters
        )
    }
    
    
}
