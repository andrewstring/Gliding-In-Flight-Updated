//
//  Location.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import CoreLocation

struct Location: Codable {
    let date: String
    let latitude: Double
    let longitude: Double
    let altitude: Double?
    let speed: Double?
    
    // Computed property for CLLocationCoordinate2D
    var coordLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    init(date: String, latitude: Double, longitude: Double, altitude: Double? = nil, speed: Double? = nil) {
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.speed = speed
    }
}

struct LocationResponse: Decodable {
    let message: String
    let data: Location?
}
