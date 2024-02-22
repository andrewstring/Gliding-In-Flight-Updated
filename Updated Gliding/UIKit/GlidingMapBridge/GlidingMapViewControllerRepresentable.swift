//
//  GlidingMapViewControllerRepresentable.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct GlidingMapViewControllerRepresentable: UIViewControllerRepresentable {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var locationModel: LocationModel
    @EnvironmentObject var barometricModel: BarometricModel
    @EnvironmentObject var flightStore: FlightStore
    @EnvironmentObject var gliderStore: GliderStore
    
    // TRY Removing
    typealias UIViewControllerType = GlidingMapViewController
    
    func makeUIViewController(context: Context) -> GlidingMapViewController {
        return GlidingMapViewController(navigationModel: navigationModel, locationModel: locationModel, barometricModel: barometricModel, flightStore: flightStore, gliderStore: gliderStore)
    }
    
    func updateUIViewController(_ uiViewController: GlidingMapViewController, context: Context) {
        if uiViewController.mapState != navigationModel.mapState {
            uiViewController.mapState = navigationModel.mapState
        }
    }
}
