//
//  LocationAuthorizationRequest.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationRequestView: View {
    @EnvironmentObject var locationModel: LocationModel
    
    var body: some View {
        let locationAuthorizationStatus = locationModel.locationAuthorizationStatus
        switch locationAuthorizationStatus {
        case .authorizedAlways:
            // Should never enter this case
            Text("AuthorizedAlways")
        case .authorizedWhenInUse:
            LocationAuthorizationInvalidView(invalidAuthorizationMessage: "Location services have only been enabled for \"When In Use\". Please enable them for \"Always\"")
        case .denied:
            LocationAuthorizationInvalidView(invalidAuthorizationMessage: "Location services have been denied. Please enable them for \"Always\"")
        case .restricted:
            LocationAuthorizationInvalidView(invalidAuthorizationMessage: "Location services have been restricted. Please enable them for \"Always\"")
        case .notDetermined:
            LocationAuthorizationInvalidView(invalidAuthorizationMessage: "Location services have not been determined. Please enable them for \"Always\"")
        default:
            ErrorView(errorMessage: "Issue with location services")
        }
    }
}

#Preview {
    LocationAuthorizationRequestView()
}
