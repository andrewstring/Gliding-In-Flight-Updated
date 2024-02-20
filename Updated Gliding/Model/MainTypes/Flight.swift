//
//  Flight.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

class Flight: Codable, ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var locations: [Location]
    @Published var absoluteBarometricAltitudes: [AbsoluteBarometricAltitude]
    @Published var relativeBarometricAltitudes: [RelativeBarometricAltitude]
    let glider: Glider
    let dateOfFlight: String
    
//    var representation: String {
//        do {
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(self)
//            return String(data: jsonData, encoding: String.Encoding.utf8)!
//        } catch {
//            return "ERROR"
//        }
//    }
    
    init(id: String, name: String, glider: Glider, dateOfFlight: String,
         locations: [Location], absoluteBarometricAltitudes: [AbsoluteBarometricAltitude], relativeBarometricAltitudes: [RelativeBarometricAltitude]) {
        self.id = id
        self.name = name
        self.glider = glider
        self.dateOfFlight = dateOfFlight
        self.locations = locations
        self.absoluteBarometricAltitudes = absoluteBarometricAltitudes
        self.relativeBarometricAltitudes = relativeBarometricAltitudes
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case glider
        case dateOfFlight
        case locations
        case absoluteBarometricAltitudes
        case relativeBarometricAltitudes
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
        } catch {
            throw error
        }
    }
}

struct FlightResponse: Decodable {
    let message: String
    let data: Flight?
}
