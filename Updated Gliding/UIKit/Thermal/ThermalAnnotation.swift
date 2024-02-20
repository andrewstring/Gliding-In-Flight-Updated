//
//  ThermalAnnotation.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import MapKit

class ThermalAnnotation: MKPointAnnotation {
    let id: String
    
    init(thermal: Thermal) {
        self.id = thermal.id
        super.init()
        self.coordinate = thermal.coordLocation
    }
}
