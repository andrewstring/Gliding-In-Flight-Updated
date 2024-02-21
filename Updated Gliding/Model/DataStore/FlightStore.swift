//
//  FlightStore.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

// Handles the persistent storage of the flight
class FlightStore: ObservableObject {
    @Published var flight: Flight?
    
    init() {
        Task {
            try await self.flightLoad()
        }
    }
        
    private static func retrieveFlightURL() throws -> URL {
        do {
            let flightURL = try FileManager.default.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: true)
                .appendingPathComponent("flight.data")
            return flightURL
        } catch {
            throw FlightStoreError.flightURLRetrievalError
        }
    }
    
    func flightLoad() async throws {
        let task = Task<Flight?, Error> {
            do {
                let flightURL = try Self.retrieveFlightURL()
                do {
                    let flightData = try Data(contentsOf: flightURL)
                    let decodedFlightData = try JSONDecoder().decode(Flight.self, from: flightData)
                    return decodedFlightData
                } catch {
                    throw FlightStoreError.parsingFlightDataError
                }
            } catch {
                throw error
            }
        }
        self.flight = try await task.value
    }
    
    @discardableResult
    func flightSave(flight: Flight) async throws -> Flight? {
        let task = Task<Flight?, Error> {
            do {
                let flightURL = try Self.retrieveFlightURL()
                do {
                    let encodedFlight = try JSONEncoder().encode(flight)
                    try encodedFlight.write(to: flightURL)
                    try await self.flightLoad()
                    return flight
                } catch {
                    throw FlightStoreError.flightSaveError
                }
            } catch {
                throw error
            }
        }
        return try await task.value
    }
    
    func flightRemove() async throws -> Void {
        let task = Task<Void, Error> {
            do {
                let flightURL = try Self.retrieveFlightURL()
                do {
                    let emptyFlight = Data()
                    try emptyFlight.write(to: flightURL)
                } catch {
                    throw FlightStoreError.flightRemoveError
                }
            } catch {
                throw error
            }
        }
        return try await task.value
    }
}


// Flight Management Functions
extension FlightStore {
    func createFlight(name: String, glider: Glider) {
        let flight = Flight(
            id: UUID().uuidString,
            name: name,
            glider: glider,
            dateOfFlight: DateTime().toString(),
            locations: [],
            absoluteBarometricAltitudes: [],
            relativeBarometricAltitudes: []
        )
        self.flight = flight
    }
    
    func addNewLocationToFlight(newLocation: Location) throws {
        
    }
    
    func addNewAbsoluteBarometricAltitudeToFlight(newAbsoluteBarometricAltitude: AbsoluteBarometricAltitude) throws {
        
    }
    
    func addNewRelativeBarometricAltitudeToFlight(newRelativeBarometricAltitude: RelativeBarometricAltitude) throws {
        
    }
    
}
