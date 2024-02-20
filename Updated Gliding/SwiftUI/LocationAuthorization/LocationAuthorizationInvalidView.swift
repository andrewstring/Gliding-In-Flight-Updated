//
//  LocationAuthorizationInvalid.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/19/24.
//

import SwiftUI

struct LocationAuthorizationInvalidView: View {
    var body: some View {
        @State var invalidAuthorizationMessage String?
        
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
