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
    
    func exceedsThresholdAltitudeDelta(newAbsoluteBarometricAltitude: AbsoluteBarometricAltitude) throws -> Bool {
        guard self.absoluteAltitude != nil && newAbsoluteBarometricAltitude.absoluteAltitude != nil else { throw BarometricAltitudeError.ThresholdAltitudeCallWithoutAltitudeDataError }
        return abs(self.absoluteAltitude! - newAbsoluteBarometricAltitude.absoluteAltitude!) > ServicesConfig.thresholdAbsoluteAltitudeDelta
    }
    
    static func exceedsThresholdAltitudeDelta(altitudeDelta: Double) throws -> Bool {
        return altitudeDelta > ServicesConfig.thresholdAbsoluteAltitudeDelta
    }
    
    func altitudeDelta(newAbsoluteBarometricAltitude: AbsoluteBarometricAltitude) throws -> Double {
        guard let newAbsoluteAltitude = newAbsoluteBarometricAltitude.absoluteAltitude else { throw BarometricAltitudeError.AltitudeDeltaCalculationWithNoAbsoluteAltitudeError }
        guard let absoluteAltitude = self.absoluteAltitude else { throw BarometricAltitudeError.AltitudeDeltaCalculationWithNoAbsoluteAltitudeError }
        return abs(newAbsoluteAltitude - absoluteAltitude)
    }
}

struct AbsoluteBarometricAltitudeResponse: Decodable {
    let message: String
    let data: AbsoluteBarometricAltitude?
}
