//
//  RelativeBarometricAltitude.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct RelativeBarometricAltitude: Codable {
    var date: String
    var relativeAltitude: Double?
    var relativePressure: Double?
    
    init(date: String, relativeAltitude: Double?, relativePressure: Double?) {
        self.date = date
        self.relativeAltitude = relativeAltitude
        self.relativePressure = relativePressure
    }
}

struct RelativeBarometricAltitudeResponse: Decodable {
    let message: String
    let data: RelativeBarometricAltitude?
}
