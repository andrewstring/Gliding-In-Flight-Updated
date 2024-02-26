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
    static func getGlider(gliderName: String) {
        APIBase.getRequest(path: "\(gliderRoute)?name=\(gliderName)", responseType: GliderResponse.self)
    }
    
    // Post Request
    static func addGlider(gliderData: Glider) throws {
        do {
            try APIBase.postRequest(path: gliderRoute, responseType: GliderResponse.self, requestData: gliderData)
        } catch {
            throw error
        }
    }
    
    // Put Request
    static func updateGlider(gliderName: String, gliderData: Glider) throws {
        do {
            try APIBase.putRequest(path: "\(gliderRoute)?name=\(gliderName)", responseType: GliderResponse.self, requestData: gliderData)
        } catch {
            throw error
        }
    }
    
    // Delete Request
    static func deleteGlider(gliderData: Glider) throws {
        do {
            try APIBase.deleteRequest(path: gliderRoute, responseType: GliderResponse.self, requestData: gliderData)
        } catch {
            throw error
        }
    }
}
