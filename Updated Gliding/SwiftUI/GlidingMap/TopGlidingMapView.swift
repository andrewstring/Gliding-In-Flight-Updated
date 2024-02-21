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
        Button(action: expandTopGlidingMapView, label: {
            Image(systemName: "ellipsis.rectangle.fill")
                .font(.system(.largeTitle))
                .foregroundColor(.gray)
        })
        .frame(height: isExpanded ? 200.0 : 50.0)
    }
}

#Preview {
    TopGlidingMapView()
}
