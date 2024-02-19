//
//  APIFlight.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct APIFlight {
    static let gliderRoute = APIConfig.gliderRoute
    
    // Get Request
    static func getFlight(flightId: String) {
        APIBase.getRequest(path: Self.gliderRoute, responseType: FlightResponse.self)
    }
    
    // Post Request
    static func addFlight(flightData: Flight) throws {
        do {
            try APIBase.postRequest(path: Self.gliderRoute, responseType: FlightResponse.self, requestData: flightData)
        } catch {
            throw error
        }
    }
    
    // Put Request
    static func updateFlight(flightData: Flight) throws {
        
    }
    
    // Delete Request
    static func deleteFlight(flightId: String) {
        
    }
}
