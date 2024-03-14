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
        
        let degreeDiff = degrees - heading.trueHeading
        
        print("Heading Difference")
        print(degreeDiff)
        return degreeDiff
    }
    
}
