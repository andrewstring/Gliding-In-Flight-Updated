//
//  ErrorView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        @State var errorMessage: String?
        
        if errorMessage != nil {
            Text(errorMessage!)
        } else {
            Text("ERROR")
        }
    }
}

#Preview {
    ErrorView()
}
