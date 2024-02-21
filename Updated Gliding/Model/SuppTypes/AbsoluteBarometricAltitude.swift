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
    
    func exceedsThresholdAltitude(newAbsoluteBarometricAltitude: AbsoluteBarometricAltitude) throws -> Bool {
        guard self.absoluteAltitude != nil && newAbsoluteBarometricAltitude.absoluteAltitude != nil else { throw BarometricAltitudeError.ThresholdAltitudeCallWithoutAltitudeData }
        return abs(self.absoluteAltitude! - newAbsoluteBarometricAltitude.absoluteAltitude!) > ServicesConfig.thresholdAltitude
    }
}

struct AbsoluteBarometricAltitudeResponse: Decodable {
    let message: String
    let data: AbsoluteBarometricAltitude?
}
