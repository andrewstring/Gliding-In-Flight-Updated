//
//  GlidingMapView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import SwiftUI

struct GlidingMapView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var locationModel: LocationModel
    
    var body: some View {
        TopGlidingMapView()
        GlidingMapViewControllerRepresentable()
        BottomGlidingMapView()
    }
}

#Preview {
    GlidingMapView()
}