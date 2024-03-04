//
//  Flight.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

class Flight: Codable, ObservableObject, Identifiable {
    @Published var id: String
    @Published var name: String
    @Published var locations: [Location]
    @Published var absoluteBarometricAltitudes: [AbsoluteBarometricAltitude]
    @Published var relativeBarometricAltitudes: [RelativeBarometricAltitude]
    @Published var thermals: [Thermal]
    let glider: Glider
    let dateOfFlight: String
    
    // Route Overview info
    var totalTime: Double = 0.0
    var distanceTraveled: Double = 0.0
    var gpsHeightGained: Double = 0.0
    var absoluteBarometricHeightGained: Double = 0.0
    var relativeBarometricHeightGained: Double = 0.0
    var maxHeight: Double = 0.0
    var minLatitude: Double?
    var maxLatitude: Double?
    var minLongitude: Double?
    var maxLongitude: Double?
    
    init(id: String, name: String, glider: Glider, dateOfFlight: String,
         locations: [Location], absoluteBarometricAltitudes: [AbsoluteBarometricAltitude], relativeBarometricAltitudes: [RelativeBarometricAltitude], thermals: [Thermal]) {
        self.id = id
        self.name = name
        self.glider = glider
        self.dateOfFlight = dateOfFlight
        self.locations = locations
        self.absoluteBarometricAltitudes = absoluteBarometricAltitudes
        self.relativeBarometricAltitudes = relativeBarometricAltitudes
        self.thermals = thermals
    }
    
    func addNewLocationToFlight(newLocation: Location) throws {
        self.locations.append(newLocation)
        if self.minLatitude == nil { self.minLatitude = newLocation.latitude }
        if self.maxLatitude == nil { self.maxLatitude = newLocation.latitude }
        if self.minLongitude == nil { self.minLongitude = newLocation.longitude }
        if self.maxLongitude == nil { self.maxLongitude = newLocation.longitude }
        if newLocation.latitude < self.minLatitude! {
            self.minLatitude = newLocation.latitude
        }
        else if newLocation.latitude > self.maxLatitude! {
            self.maxLatitude = newLocation.latitude
        }
        if newLocation.longitude < self.minLongitude! {
            self.minLongitude = newLocation.longitude
        }
        else if newLocation.longitude > self.maxLongitude! {
            self.maxLongitude = newLocation.longitude
        }
    }
    
    func addNewThermalToFlight(newThermal: Thermal) throws {
        self.thermals.append(newThermal)
        do {
            try APIThermal.addThermal(thermalData: newThermal)
        } catch {
            print(error)
        }
    }
    
    func addNewAbsoluteBarometricAltitudeToFlight(newAbsoluteBarometricAltitude: AbsoluteBarometricAltitude) throws {
        
    }
    
    func addNewRelativeBarometricAltitudeToFlight(newRelativeBarometricAltitude: RelativeBarometricAltitude) throws {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case glider
        case dateOfFlight
        case locations
        case absoluteBarometricAltitudes
        case relativeBarometricAltitudes
        case thermals
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(String.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            glider = try values.decode(Glider.self, forKey: .glider)
            dateOfFlight = try values.decode(String.self, forKey: .dateOfFlight)
            locations = try values.decode([Location].self, forKey: .locations)
            absoluteBarometricAltitudes = try values.decode([AbsoluteBarometricAltitude].self, forKey: .absoluteBarometricAltitudes)
            relativeBarometricAltitudes = try values.decode([RelativeBarometricAltitude].self, forKey: .relativeBarometricAltitudes)
            thermals = try values.decode([Thermal].self, forKey: .thermals)
        } catch {
            throw error
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(glider, forKey: .glider)
            try container.encode(dateOfFlight, forKey: .dateOfFlight)
            try container.encode(locations, forKey: .locations)
            try container.encode(absoluteBarometricAltitudes, forKey: .absoluteBarometricAltitudes)
            try container.encode(relativeBarometricAltitudes, forKey: .relativeBarometricAltitudes)
            try container.encode(thermals, forKey: .thermals)
        } catch {
            throw error
        }
    }
}

struct FlightResponse: Decodable {
    let message: String
    let data: Flight?
}
