//
//  ErrorView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct ErrorView: View {
    @State var errorMessage: String?
    
    var body: some View {
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
