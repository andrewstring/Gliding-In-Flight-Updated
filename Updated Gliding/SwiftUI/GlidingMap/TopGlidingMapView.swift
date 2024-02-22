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
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
                    Button("JKLJKL", action: {print("JKL")})
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
