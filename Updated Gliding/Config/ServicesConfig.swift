//
//  ServicesConfig.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

struct ServicesConfig {
    static let activityType: CLActivityType = .automotiveNavigation
    
    static let thresholdDistance = 100.0
    static let thresholdGPSAltitude = 0.01
    static let thresholdAbsoluteAltitudeDelta = 3.0
    static let thresholdRelativeAltitudeDelta = 3.0
    
    static let thresholdThermalDistance = 100.0
}
