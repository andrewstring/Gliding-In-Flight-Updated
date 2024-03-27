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
                    Text("Direction")
                    HStack {
                        let heading = self.locationModel.currentHeadingFromThermal
                        switch heading {
                        case let _ where heading == nil:
                            Text("_")
                                .font(.system(size: 56.0))
                                .bold()
                        case let _ where heading! < 0:
                            Image(systemName: "arrow.right")
                                .font(.system(size: 40.0))
                                .padding(.vertical, 5.0)
//                            Text("->")
//                                .font(.system(size: 56))
//                                .bold()
                        case let _ where heading! > 0:
                            Image(systemName: "arrow.left")
                                .font(.system(size: 40.0))
                                .padding(.vertical, 5.0)
//                            Text("->")
//                            Text("<-")
//                                .font(.system(size: 56))
//                                .bold()
                        default:
                            Text("_")
                                .font(.system(size: 56.0))
                                .bold()
                        }
                    }
                    Text(self.locationModel.currentHeadingFromThermal != nil ? String(self.locationModel.currentHeadingFromThermal!) : "")
                }
                Spacer()
                VStack {
                    Text("Altitude Difference")
                    HStack {
                        let altitudeDiff = self.locationModel.currentAltitudeFromThermal
                        switch altitudeDiff {
                        case let _ where altitudeDiff == nil:
                            Text("_")
                                .font(.system(size: 56))
                                .bold()
                        case let _ where altitudeDiff! < 0:
                            Image(systemName: "arrow.down")
                                .font(.system(size: 40.0))
                                .padding(.vertical, 5.0)
                        case let _ where altitudeDiff! > 0:
                            Image(systemName: "arrow.up")
                                .font(.system(size: 40.0))
                                .padding(.vertical, 5.0)
                        default:
                            Text("_")
                                .font(.system(size: 56.0))
                                .bold()
                        }
                    }
                    Text(self.locationModel.currentAltitudeFromThermal != nil ? String(self.locationModel.currentAltitudeFromThermal!) : "")
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
