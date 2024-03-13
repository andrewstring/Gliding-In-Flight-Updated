//
//  NavigationModel.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import CoreLocation

class NavigationModel: ObservableObject {
    var locationModel: LocationModel?
    var barometricModel: BarometricModel?
    var gliderStore: GliderStore?
    var flightStore: FlightStore?
    var thermalStore: ThermalStore?
    
    @Published var mapState: MapState = .preFlight {
        didSet {
            switch mapState {
            case .preFlight:
                if let locationModel = self.locationModel {
                    locationModel.flightStore = nil
                }
                if let barometricModel = self.barometricModel {
                    barometricModel.flightStore = nil
                }
            case .inFlight, .inOverviewFlight:
                if let locationModel = self.locationModel {
                    locationModel.flightStore = self.flightStore
                }
                if let barometricModel = self.barometricModel {
                    barometricModel.flightStore = self.flightStore
                }
            case .postFlight:
                if let locationModel = self.locationModel {
                    locationModel.flightStore = nil
                }
                if let barometricModel = self.barometricModel {
                    barometricModel.flightStore = nil
                }
            }
        }
    }
    
    func attach(_ locationModel: LocationModel, _ barometricMode: BarometricModel, _ gliderStore: GliderStore, _ flightStore: FlightStore) {
        self.locationModel = locationModel
        self.barometricModel = barometricMode
        self.gliderStore = gliderStore
        self.flightStore = flightStore
        
        self.locationModel!.flightStore = flightStore
        self.barometricModel!.flightStore = flightStore
        self.locationModel!.thermalStore = thermalStore
     }
    
    @MainActor
    func startNavigation() {
        self.mapState = .inFlight
        guard let glider = self.gliderStore?.glider else { print(NavigationModelError.StartingNavigationWithNoGliderError.localizedDescription); return }
        guard let flightStore = self.flightStore else { print(NavigationModelError.StartingNavigtationWithNoFlightStoreError.localizedDescription); return }
        flightStore.createFlight(name: "TEST", glider: glider)
    }
    
    @MainActor
    func startOverviewNavigation() {
        self.mapState = .inOverviewFlight
        guard let glider = self.gliderStore?.glider else { print(NavigationModelError.StartingNavigationWithNoGliderError.localizedDescription); return }
        guard let flightStore = self.flightStore else { print(NavigationModelError.StartingNavigtationWithNoFlightStoreError.localizedDescription); return }
        flightStore.createFlight(name: "TEST", glider: glider)
    }
    
    func stopNavigation() {
        self.mapState = .postFlight
    }
    
    func setPreNavigation() {
        self.mapState = .preFlight
    }
    
    func sendFlight() {
        print("SEND FLIGHT")
        
        // SEND VIA DATABASE
        guard let flightStore = self.flightStore else { return }
        guard let flight = flightStore.flight else { return }
        print(flight)
    }
}

enum MapState {
    case preFlight
    case inFlight
    case inOverviewFlight
    case postFlight
}
