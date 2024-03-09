//
//  TopGlidingMapView+Navigation.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 3/8/24.
//

import SwiftUI

extension TopGlidingMapView {
    var TopGlidingNavigationView: some View {
        VStack {
            Text("Navigation")
                .font(.title)
                .bold()
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Text("<")
                        Text(">")
                    }
                    Text("Direction Text")
                }
                Spacer()
                VStack {
                    HStack {
                        Text("UP")
                        Text("DOWN")
                    }
                    Text("Altitude Text")
                }
                Spacer()
            }
            .padding()
            Button("Cancel Navigation", action: cancelNavigation)
                .font(.headline)
                .foregroundColor(.black)
                .padding(10.0)
                .background(.gray)
                .cornerRadius(10.0)
        }
    }
}
