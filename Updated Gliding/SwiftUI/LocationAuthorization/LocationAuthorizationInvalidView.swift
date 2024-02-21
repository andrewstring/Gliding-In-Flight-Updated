//
//  LocationAuthorizationInvalidView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationInvalidView: View {
    @EnvironmentObject var locationModel: LocationModel
    
    @State var invalidAuthorizationMessage: String?
    @State var promptNodeShown = false
    
    var body: some View {
        if invalidAuthorizationMessage != nil {
            
            VStack {
                Image(systemName: "location.fill").font(.system(size: 60.0)).padding(.bottom, 20.0)
                    .symbolEffect(.pulse, isActive: true)
                Text(invalidAuthorizationMessage!).font(.headline)
                    .padding(.bottom, 20.0)
                Button("Enable Location", action: enableLocation)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(10.0)
                    .background(.gray)
                    .cornerRadius(10.0)
                    .padding(.bottom, 20.0)
                if promptNodeShown {
                    Text("NOTE: If location prompt does not show up, you must enable \"Location: Always\" within settings and refresh application")
                        .font(.subheadline)
                }
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20.0)
        } else {
            Text("ERROR").font(.headline).multilineTextAlignment(.center).padding(.horizontal, 20.0)
        }
    }
    
    func enableLocation() {
        locationModel.requestLocation()
        promptNodeShown = true
    }
}

#Preview {
    LocationAuthorizationInvalidView()
}
