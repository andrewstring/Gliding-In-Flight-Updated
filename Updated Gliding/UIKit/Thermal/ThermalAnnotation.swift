//
//  ThermalAnnotation.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import MapKit

class ThermalAnnotation: MKPointAnnotation {
    let id: String
    let userType: UserType
    
    enum UserType {
        case ownUser
        case otherUser
    }
    
    init(thermal: Thermal, userType: UserType) {
        self.id = thermal.id
        self.userType = userType
        super.init()
        self.coordinate = thermal.coordLocation
    }
}
