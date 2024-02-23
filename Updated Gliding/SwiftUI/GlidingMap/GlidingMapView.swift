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
        
        switch navigationModel.mapState {
        case .inFlight, .preFlight:
            TopGlidingMapView()
        case .inOverviewFlight:
            EmptyView()
        case .postFlight:
            TopPostFlightMetricsView()
        }
        GlidingMapViewControllerRepresentable()
        BottomGlidingMapView()
    }
}

#Preview {
    GlidingMapView()
}
