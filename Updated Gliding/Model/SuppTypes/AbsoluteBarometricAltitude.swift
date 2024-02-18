//
//  AbsoluteBarometricAltitude.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct AbsoluteBarometricAltitude: Codable {
    var date: String
    var absoluteAltitude: Double?
    var absoluteAccuracy: Double?
    var absolutePrecision: Double?
}

struct AbsoluteBarometricAltitudeResponse: Decodable {
    let message: String
    let data: AbsoluteBarometricAltitude?
}
