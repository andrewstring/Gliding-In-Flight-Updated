//
//  BottomGlidingMapView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/21/24.
//

import SwiftUI

struct BottomGlidingMapView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        HStack {
            Spacer()
            
            switch navigationModel.mapState {
            case .preFlight:
                BottomGlidingMapButtonView(text: "Start Flight", action: navigationModel.startNavigation)
                BottomGlidingMapButtonView(text: "Start Overview Flight", action: navigationModel.startOverviewNavigation)
            case .inFlight:
                BottomGlidingMapButtonView(text: "End Flight", action: navigationModel.stopNavigation)
            case .postFlight:
                BottomGlidingMapButtonView(text: "Restart Flight", action: navigationModel.startNavigation)
            }
            Spacer()
        }
        .padding(.vertical, 20.0)
    }
}

#Preview {
    BottomGlidingMapView()
}
