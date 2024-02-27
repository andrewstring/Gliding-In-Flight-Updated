//
//  TopGlidingMapView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/21/24.
//

import SwiftUI

struct TopGlidingMapView: View {
    @State var isExpanded = false
    
    private func expandTopGlidingMapView() {
        isExpanded.toggle()
    }
    
    var body: some View {
        VStack {
            if isExpanded {
                VStack {
                    Button("Test 1", action: {print("Test 1")})
                    Button("Test 2", action: {print("Test 2")})
                    Button("Test 3", action: {print("Test 3")})
                    Button("Test 4", action: {print("Test 4")})
                    Button("Test 5", action: {print("Test 5")})
                }
                .padding(.bottom, 20.0)
                .font(.title2)
            }
            Button(action: expandTopGlidingMapView, label: {
                Image(systemName: "ellipsis.rectangle.fill")
                    .font(.system(.largeTitle))
                    .foregroundColor(.gray)
            })
        }
        .padding(.vertical, 20.0)
    }
}

#Preview {
    TopGlidingMapView()
}
