//
//  GlidingMapViewConfig.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/23/24.
//

import UIKit

struct GlidingMapViewConfig {
    static var preFlightZoom = 10000.0
    static var inFlightZoom = 3000.0
    static var inOverviewFlightZoom = 20000.0
    static var postFlightZoom = 6000.0
    
    static var polylineStrokeColor: UIColor = .blue
    static var polylineLineWidth: CGFloat = 15
}
