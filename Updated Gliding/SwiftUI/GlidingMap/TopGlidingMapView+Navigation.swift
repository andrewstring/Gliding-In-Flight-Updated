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
                        let heading = self.locationModel.currentHeadingFromThermal
                        switch heading {
                        case let _ where heading == nil:
                            Text("NIL")
                        case let _ where heading! < 0:
                            Text("<")
                        case let _ where heading! > 0:
                            Text(">")
                        default:
                            Text("")
                        }
                    }
                    Text(self.locationModel.currentHeadingFromThermal != nil ? String(self.locationModel.currentHeadingFromThermal!) : "")
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
