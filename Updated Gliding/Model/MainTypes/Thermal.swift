//
//  Thermal.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import CoreLocation

struct Thermal: Codable {
    let id: String
    let location: Location
    let glider: Glider
    let detectedOn: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
}

struct ThermalResponse: Decodable {
    let message: String
    let data: Thermal?
}
