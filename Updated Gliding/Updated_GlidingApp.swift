//
//  Updated_GlidingApp.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import SwiftUI

@main
struct Updated_GlidingApp: App {
    
    @StateObject var navigationModel = NavigationModel()
    @StateObject var locationModel = LocationModel()
    @StateObject var barometricModel = BarometricModel()
    @StateObject var gliderStore = GliderStore()
    @StateObject var flightStore = FlightStore()
    @StateObject var thermalStore = ThermalStore()
    @State var didAttach = false
    
    func attach() {
        if !didAttach {
            navigationModel.attach(locationModel, barometricModel, gliderStore, flightStore, thermalStore)
            didAttach = true
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            if locationModel.locationAuthorizationStatus == .authorizedAlways {
                if gliderStore.glider != nil {
                    GlidingMapView()
                    .environmentObject(navigationModel)
                    .environmentObject(locationModel)
                    .environmentObject(barometricModel)
                    .environmentObject(gliderStore)
                    .environmentObject(flightStore)
                    .environmentObject(thermalStore)
                    .onAppear(perform: attach)
                } else {
                    LoginView()
                    .environmentObject(gliderStore)
                    .onAppear(perform: attach)
                }
            } else {
                LocationAuthorizationRequestView()
                    .environmentObject(locationModel)
                    .onAppear(perform: attach)
            }
        }
    }
}
