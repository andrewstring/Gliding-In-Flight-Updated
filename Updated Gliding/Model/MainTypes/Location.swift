//
//  Location.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import CoreLocation

class Location: Codable {
    let coreLocation: CLLocation?
    let date: String
    let latitude: Double
    let longitude: Double
    let altitude: Double?
    let speed: Double?
    
    // Computed property for CLLocationCoordinate2D
    var coordLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    init(_ location: CLLocation) {
        self.coreLocation = location
        self.date = DateTime().toString()
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.altitude = location.altitude
        self.speed = location.speed
    }
    
    // Not a big fan of this...may delete
    /*
    init(coreLocation: CLLocation, date: String, latitude: Double, longitude: Double, altitude: Double? = nil, speed: Double? = nil) {
        self.coreLocation = coreLocation
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.speed = speed
    }
     */
    
    func exceedsThresholdDistance(newLocation: CLLocation, threshold: CLLocationDistance) throws -> Bool {
        guard let coreLocation = self.coreLocation else { throw LocationError.NoCoreLocationInLocationError }
        return coreLocation.distance(from: newLocation) > threshold
    }
    
    // For Encodable and Decodable Conformance
    enum CodingKeys: String, CodingKey {
        case date
        case latitude
        case longitude
        case altitude
        case speed
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            date = try values.decode(String.self, forKey: .date)
            latitude = try values.decode(Double.self, forKey: .latitude)
            longitude = try values.decode(Double.self, forKey: .longitude)
            altitude = try values.decode(Double.self, forKey: .altitude)
            speed = try values.decode(Double.self, forKey: .speed)
        } catch {
            throw error
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(date, forKey: .date)
            try container.encode(latitude, forKey: .latitude)
            try container.encode(longitude, forKey: .longitude)
            try container.encode(altitude, forKey: .altitude)
            try container.encode(speed, forKey: .speed)
        } catch {
            throw error
        }
    }
}

struct LocationResponse: Decodable {
    let message: String
    let data: Location?
}
