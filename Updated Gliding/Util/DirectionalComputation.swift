//
//  DirectionalComputation.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/12/24.
//

import CoreLocation

struct DirectionalComputation {
    static func getHeadingDifference(thermalCoordinates: CLLocationCoordinate2D, currentLocationCoordinates: CLLocationCoordinate2D, heading: CLHeading) -> Double {
        
        let latDiff = thermalCoordinates.latitude - currentLocationCoordinates.latitude
        let longDiff = thermalCoordinates.longitude - currentLocationCoordinates.longitude
        
        let radians = atan2(longDiff, latDiff)
        var degrees = radians * (180 / .pi)
        degrees = (degrees + 360).truncatingRemainder(dividingBy: 360)
        
        var degreeDiff = heading.trueHeading - degrees
        if (degreeDiff < -180) {
            while (degreeDiff < 0) {
                degreeDiff = degreeDiff + 360
            }
        }
        
//        if (degreeDiff < -180) {
//            degreeDiff = abs(degreeDiff) - 129
//            
//        }
        
        print("Heading Difference")
        print(degreeDiff)
        return degreeDiff
    }
    
}
