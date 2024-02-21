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
    
    var body: some Scene {
        WindowGroup {
            if locationModel.locationAuthorizationStatus == .authorizedAlways {
                if gliderStore.glider != nil {
                    GlidingMapView()
                    .background(Color(.black))
                    .environmentObject(navigationModel)
                    .environmentObject(locationModel)
                } else {
                    LoginView()
                    .background(Color(.black))
                    .environmentObject(navigationModel)
                    .environmentObject(gliderStore)
                }
            } else {
                LocationAuthorizationRequestView().environmentObject(locationModel)
            }
        }
    }
}
