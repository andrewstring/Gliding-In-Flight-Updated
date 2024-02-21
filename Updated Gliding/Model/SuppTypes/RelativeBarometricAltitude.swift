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
    
    
    func exceedsThresholdAltitude(newRelativeBarometricAltitude: RelativeBarometricAltitude) throws -> Bool {
        guard self.relativeAltitude != nil && newRelativeBarometricAltitude.relativeAltitude != nil else { throw BarometricAltitudeError.ThresholdAltitudeCallWithoutAltitudeData }
        return abs(self.relativeAltitude! - newRelativeBarometricAltitude.relativeAltitude!) > ServicesConfig.thresholdAltitude
    }
}

struct RelativeBarometricAltitudeResponse: Decodable {
    let message: String
    let data: RelativeBarometricAltitude?
}
