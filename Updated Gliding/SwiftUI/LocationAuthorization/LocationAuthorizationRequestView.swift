//
//  LocationAuthorizationRequest.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationRequestView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    
    var body: some View {
        let locationAuthorizationStatus = navigationModel.locationModel.locationAuthorizationStatus
        switch locationAuthorizationStatus {
        case .authorizedAlways:
            // Should never enter this case
            Text("AuthorizedAlways")
        case .authorizedWhenInUse:
            LocationAuthorizationInvalidView(invalidAuthorizationMessage: "JKL")
        case .denied:
        case .restricted:
        case .notDetermined:
        default:
            ErrorView(errorMessage: "Issue with location services")
        }
    }
}

#Preview {
    LocationAuthorizationRequest()
}
