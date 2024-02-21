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
    
    var body: some Scene {
        WindowGroup {
            if navigationModel.locationAuthorizationStatus == .authorizedAlways {
                if navigationModel.gliderStore.glider != nil {
                    GlidingMapView().environmentObject(navigationModel)
                } else {
                    LoginView().environmentObject(navigationModel)
                }
            } else {
                LocationAuthorizationRequestView().environmentObject(navigationModel)
            }
        }
    }
}
