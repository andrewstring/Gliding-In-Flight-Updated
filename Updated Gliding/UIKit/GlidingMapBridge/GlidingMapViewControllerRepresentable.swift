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
    
    // TRY Removing
    typealias UIViewControllerType = GlidingMapViewController
    
    func makeUIViewController(context: Context) -> GlidingMapViewController {
        return GlidingMapViewController(navigationModel: navigationModel, locationModel: locationModel)
    }
    
    func updateUIViewController(_ uiViewController: GlidingMapViewController, context: Context) {
        uiViewController.mapState = navigationModel.mapState
    }
}
