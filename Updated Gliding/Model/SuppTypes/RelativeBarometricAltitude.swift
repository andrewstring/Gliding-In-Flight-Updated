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
    
    
    func exceedsThresholdAltitudeDelta(newRelativeBarometricAltitude: RelativeBarometricAltitude) throws -> Bool {
        guard self.relativeAltitude != nil && newRelativeBarometricAltitude.relativeAltitude != nil else { throw BarometricAltitudeError.ThresholdAltitudeCallWithoutAltitudeDataError }
        return abs(self.relativeAltitude! - newRelativeBarometricAltitude.relativeAltitude!) > ServicesConfig.thresholdRelativeAltitudeDelta
    }
    
    static func exceedsThresholdAltitudeDelta(altitudeDelta: Double) throws -> Bool {
        return altitudeDelta > ServicesConfig.thresholdRelativeAltitudeDelta
    }
    
    func altitudeDelta(newRelativeBarometricAltitude: RelativeBarometricAltitude) throws -> Double {
        guard let newRelativeAltitude = newRelativeBarometricAltitude.relativeAltitude else { throw BarometricAltitudeError.ThresholdAltitudeCallWithoutAltitudeDataError }
        guard let relativeAltitude = self.relativeAltitude else { throw BarometricAltitudeError.AltitudeDeltaCalculationWithNoRelativeAltitudeError }
        return abs(newRelativeAltitude - relativeAltitude)
    }
}

struct RelativeBarometricAltitudeResponse: Decodable {
    let message: String
    let data: RelativeBarometricAltitude?
}
