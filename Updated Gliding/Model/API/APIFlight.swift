//
//  APIFlight.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct APIFlight {
    static let flightRoute = APIConfig.flightRoute
    
    // Get Request
    static func getFlight(flightId: String) {
        APIBase.getRequest(path: "\(flightRoute)?id=\(flightId)", responseType: FlightResponse.self)
    }
    
    // Post Request
    static func addFlight(flightData: Flight) throws {
        do {
            try APIBase.postRequest(path: flightRoute, responseType: FlightResponse.self, requestData: flightData)
        } catch {
            throw error
        }
    }
    
    // Put Request
    static func updateFlight(flightId: String, flightData: Flight) throws {
        do {
            try APIBase.putRequest(path: "\(flightRoute)?id=\(flightId)", responseType: FlightResponse.self, requestData: flightData)
        } catch {
            throw error
        }
    }
    
    // Delete Request
    static func deleteFlight(flightData: Flight) throws {
        do {
            try APIBase.deleteRequest(path: flightRoute, responseType: FlightResponse.self, requestData: flightData)
        } catch {
            throw error
        }
    }
}
