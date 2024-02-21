//
//  BottomGlidingMapButtonView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/21/24.
//

import SwiftUI

struct BottomGlidingMapButtonView: View {
    let text: String
    let action: () -> Void
    
    func none() {
        
    }
    
    var body: some View {
        Button(text, action: action)
            .font(.headline)
            .foregroundColor(.black)
            .padding(10.0)
            .background(.gray)
            .cornerRadius(10.0)
    }
}

#Preview {
    BottomGlidingMapButtonView(text: "Test", action: { print("Test") })
}
