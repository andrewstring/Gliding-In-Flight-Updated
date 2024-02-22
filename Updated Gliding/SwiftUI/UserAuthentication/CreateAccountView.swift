//
//  CreateAccountView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var username = ""
    @State private var password = ""
    
    private func submitButtonAction() {
        
    }
    
    var body: some View {
        VStack {
            Text("Create Account").font(.system(.largeTitle))
                .padding(.bottom, 20.0)
            
            Label("Username", systemImage: "person.fill")
            TextField("Username", text: $username, prompt: Text("Required"))
                .disableAutocorrection(true)
                .padding(.bottom, 20.0)
            
            Label("Password", systemImage: "lock.fill")
            TextField("Password", text: $password, prompt: Text("Required"))
                .disableAutocorrection(true)
                .padding(.bottom, 20.0)
            
            Button("Submit", action: submitButtonAction)
                .font(.headline)
                .foregroundColor(.black)
                .padding(10.0)
                .background(.gray)
                .cornerRadius(10.0)
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    CreateAccountView()
}
