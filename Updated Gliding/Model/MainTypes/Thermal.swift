//
//  Thermal.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import CoreLocation

struct Thermal: Codable, Identifiable {
    let id: String
    let location: Location
    let glider: Glider?
    let detectedOn: String
    
    // Computed property for CLLocationCoordinate2D
    var coordLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
    
    init(_ location: Location, _ glider: Glider? = nil) {
        self.id = UUID().uuidString
        self.location = location
        self.detectedOn = DateTime().toString()
        guard let glider = glider else { self.glider = nil; return }
        self.glider = glider
    }
    
    func exceedsThresholdDistance(newLocation: Location) throws -> Bool {
        return CLLocation(latitude: self.location.latitude, longitude: self.location.longitude).distance(from: CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)) > ServicesConfig.thresholdThermalDistance
    }
}

struct ThermalResponse: Decodable {
    let message: String
    let data: Thermal?
}

struct ThermalMultiResponse: Decodable {
    let message: String
    let data: [Thermal]
}
