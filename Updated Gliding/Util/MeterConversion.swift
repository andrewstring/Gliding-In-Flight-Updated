//
//  MeterConversion.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/3/24.
//

import Foundation

struct MeterConversion {
    
    static let earthRadius = 6378137.0
    
    // Based on Haversine Formula
    static func latitudinalDistanceToMeters(latitudinalRange: Double) -> Double {
        let latitudinalDistance = latitudinalRange * .pi / 180.0
        
        return Self.earthRadius * latitudinalDistance
    }
    
    // Based on Haversine Formula
    // Longitudinal distance depends on latitude also...Takes average on min/max latitude
    static func longitudinalDistanceToMeters(longitudinalRange: Double, minLatitude: Double, maxLatitude: Double) -> Double {
        let longitudinalDistance = longitudinalRange * .pi / 180.0
        
        let avgLatitude = (minLatitude + maxLatitude) / 2.0
        let cosLatitude = cos(avgLatitude * .pi / 180.0)
        let adjustedLongitudinalDistance = longitudinalDistance * cosLatitude
        
        return Self.earthRadius * adjustedLongitudinalDistance
    }
}
