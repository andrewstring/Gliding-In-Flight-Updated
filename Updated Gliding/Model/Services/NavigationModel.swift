//
//  NavigationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class NavigationModel: ObservableObject {
    @Published var mapState: MapState = .preFlight
    
    var flight: Flight?
    
    init() {
//        self.locationModel = LocationModel()
//        self.barometricModel = BarometricModel()
        
//        assignNavigationModelToOtherModels()
        // Must trigger barometric start AFTER assignNavigationModelToOtherModels
//        self.barometricModel.
    }
    
//    func assignNavigationModelToOtherModels() {
//        self.locationModel.navigationModel = self
//        self.barometricModel.navigationModel = self
//    }
    
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
    
//    func addNewLocationToFlight(newLocation: CLLocation) throws {
//        if self.mapState == .inFlight {
//            guard let flight = self.flight else { throw NavigationModelError.AddingLocationWithNoFlightError }
//            if let lastLocation = flight.locations.last {
//                do {
//                    if try lastLocation.exceedsThresholdDistance(newLocation: newLocation) {
//                        flight.locations.append(Location(newLocation))
//                    }
//                } catch {
//                    throw error
//                }
//            } else {
//                flight.locations.append(Location(newLocation))
//            }
//            
//            Task {
//                try await self.flightStore.flightSave(flight: flight)
//            }
//        }
    
//    func startNavigation(flightName: String, glider: Glider) {
//        self.mapState = MapState.inFlight
//        self.createFlight(name: flightName, glider: glider)
//    }
    
    func startNavigation() {
        self.mapState = .inFlight
    }
    
    func stopNavigation() {
        self.mapState = .postFlight
    }
    
//    func stopNavigation() async throws {
//        self.mapState = .postFlight
//        self.mapState = .postFlight
//        do {
//            guard let flight = self.flight else { throw NavigationModelError.StoppingNavigationWithNoFlightError }
//            try await self.flightStore.flightSave(flight: flight)
//        } catch {
//            throw error
//        }
//    }
}

enum MapState {
    case preFlight
    case inFlight
    case postFlight
}
