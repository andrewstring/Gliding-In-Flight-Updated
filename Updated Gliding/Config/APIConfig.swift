//
//  APIConfig.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct APIConfig {
//    static let url: String = "http://192.168.0.255"
    static let prot: String = "http"
    static let url: String = "localhost"
    static let port: String = "3000"
    
    static let gliderRoute = "/glider-tracking/glider"
    static let flightRoute = "/glider-tracking/flight"
    static let thermalRoute = "/glider-tracking/thermal"
    static let thermalRadiusRoute = thermalRoute + "/radius"
}
