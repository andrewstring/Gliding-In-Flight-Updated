//
//  RouteOverview.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation
import MapKit

struct RouteOverview {
    static func generateRouteOverview(locations: [Location]) -> MKPolyline {
        let route = MKPolyline(
            coordinates: locations.map{ $0.coordLocation }, count: locations.count
        )
        return route
    }
}
