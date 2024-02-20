//
//  LocationAuthorizationInvalidView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationInvalidView: View {
    @State var invalidAuthorizationMessage: String?
    
    var body: some View {
        if invalidAuthorizationMessage != nil {
            Text(invalidAuthorizationMessage!)
        } else {
            Text("ERROR")
        }
    }
}

#Preview {
    LocationAuthorizationInvalidView()
}
