//
//  LocationAuthorizationInvalidView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationInvalidView: View {
    @State var invalidAuthorizationMessage: String?
    
    var body: some View {
        if invalidAuthorizationMessage != nil {
            
            VStack {
                Image(systemName: "location.fill").font(.system(size: 60.0)).padding(.bottom, 20.0)
                    .symbolEffect(.pulse, isActive: true)
                Text(invalidAuthorizationMessage!).font(.headline)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20.0)
        } else {
            Text("ERROR").font(.headline).multilineTextAlignment(.center).padding(.horizontal, 20.0)
        }
    }
}

#Preview {
    LocationAuthorizationInvalidView()
}
