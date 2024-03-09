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
            case .inFlight, .inOverviewFlight:
                BottomGlidingMapButtonView(text: "Re-Center", action: {() in print("RECENTER")})
                BottomGlidingMapButtonView(text: "End Flight", action: navigationModel.stopNavigation)
            case .postFlight:
                BottomGlidingMapButtonView(text: "Restart Flight", action: navigationModel.setPreNavigation)
                BottomGlidingMapButtonView(text: "Send Flight", action: navigationModel.sendFlight)
            }
            Spacer()
        }
        .padding(.vertical, 20.0)
    }
}

#Preview {
    BottomGlidingMapView()
}
