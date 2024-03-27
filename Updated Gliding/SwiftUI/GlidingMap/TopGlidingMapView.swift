//
//  TopGlidingMapView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/21/24.
//

import SwiftUI

struct TopGlidingMapView: View {
    @EnvironmentObject var locationModel: LocationModel
    @EnvironmentObject var thermalStore: ThermalStore
    @State var isNavigating = false
    @State var isExpanded = false
    
    private func expandTopGlidingMapView() {
        isExpanded.toggle()
        isNavigating = false
    }
    
    private func handleNavigateTo(thermal: Thermal, id: String) {
        self.thermalStore.setActiveThermal(thermal: thermal)
        self.thermalStore.setActiveThermalAnnotationView(id: id)
        isExpanded = false
        isNavigating = true
    }
    
    func cancelNavigation() {
        self.thermalStore.unsetActiveThermal()
        self.thermalStore.unsetActiveThermalAnnotationView()
        isNavigating = false
        isExpanded = false
    }
    
    var body: some View {
        VStack {
            if isExpanded {
                VStack {
                    if thermalStore.thermals.count > 0 {
                        ForEach(Array(thermalStore.thermals.prefix(5))) { thermal in
                            Button(thermal.glider != nil ? thermal.glider!.name : "No Name", action: {() in self.handleNavigateTo(thermal: thermal, id: thermal.id)})
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(Color.black)
                                .font(.subheadline)
                                .clipShape(Capsule())
                        }
                    } else {
                        Text("NO THERMALS DETECTED IN AREA")
                    }
                }
                .padding(.bottom, 20.0)
                .font(.title2)
            }
            if isNavigating {
                TopGlidingNavigationView
            } else {
                Button(action: expandTopGlidingMapView, label: {
                    Image(systemName: "ellipsis.rectangle.fill")
                        .font(.system(.largeTitle))
                        .foregroundColor(.gray)
                })
            }
        }
        .padding(.vertical, 20.0)
    }
}

#Preview {
    TopGlidingMapView()
}
