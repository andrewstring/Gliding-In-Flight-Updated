//
//  APIGlider.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation


struct APIGlider {
    static let gliderRoute = APIConfig.gliderRoute
    
    // Get Request
    static func getGlider(gliderId: String) {
        APIBase.getRequest(path: "\(gliderRoute)?id=\(gliderId)", responseType: GliderResponse.self)
    }
    
    // Post Request
    static func addGlider(gliderData: Glider) throws {
        do {
            try APIBase.postRequest(path: Self.gliderRoute, responseType: GliderResponse.self, requestData: gliderData)
        } catch {
            throw error
        }
    }
    
    /*
    static func addGlider(num: String) {
//        APIBase.postRequest(path: "/glider-tracking/glider")
        let testGlider: Glider = Glider(
            id: "test\(num)",
            name: "test\(num)",
            currentLocation: Location(date: DateTime.getDateTime().toString(), latitude: 1.0, longitude: 1.0, altitude: 1.0, speed: 1.0),
            currentUpdate: DateTime.getDateTime().toString(),
            lastLocation: Location(date: DateTime.getDateTime().toString(), latitude: 1.0, longitude: 1.0, altitude: 1.0, speed: 1.0),
            lastUpdate: DateTime.getDateTime().toString()
        )
        APIBase.postRequest(path: "\(gliderRoute)", responseType: GliderResponse.self, requestData: testGlider)
    }
     */
    
    // Put Request
    static func updateGlider(gliderData: Glider) throws {
        
    }
    
    // Delete Request
    static func deleteGlider(gliderId: String) {
        
    }
}
