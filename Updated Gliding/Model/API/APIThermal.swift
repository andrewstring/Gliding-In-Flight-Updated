//
//  APITheraml.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

struct APIThermal {
    static let thermalRoute = APIConfig.thermalRoute
    static let thermalRadiusRoute = APIConfig.thermalRadiusRoute
    
    // Get Request
    static func getThermal(thermalId: String) {
        APIBase.getRequest(path: "\(thermalRoute)?id=\(thermalId)", responseType: ThermalResponse.self)
    }
    
    // Get By Radius Request
    static func getThermalByRadius(latitude: Double, longitude: Double) {
        print("GETTHERMALBYRADIUS")
        APIBase.getRequest(path: "\(thermalRadiusRoute)?lat=\(latitude)&long=\(longitude)", responseType: ThermalResponse.self)
    }
    
    // Post Request
    static func addThermal(thermalData: Thermal) throws {
        do {
            try APIBase.postRequest(path: thermalRoute, responseType: ThermalResponse.self, requestData: thermalData)
        } catch {
            throw error
        }
    }
    
    // Put Request
    static func updateThermal(thermalId: String, thermalData: Thermal) throws {
        do {
            try APIBase.putRequest(path: "\(thermalRoute)?id=\(thermalId)", responseType: ThermalResponse.self, requestData: thermalData)
        } catch {
            throw error
        }
    }
    
    // Delete Request
    static func deleteThermal(thermalData: Thermal) throws {
        do {
            try APIBase.deleteRequest(path: thermalRoute, responseType: ThermalResponse.self, requestData: thermalData)
        } catch {
            throw error
        }
    }
}
