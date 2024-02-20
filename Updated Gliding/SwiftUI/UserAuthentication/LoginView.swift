//
//  LoginView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @EnvironmentObject var navigationModel: NavigationModel
    
    private let signInButtonText = "SIGN IN"
    private func signInButtonAction() {
        // Will check with database for authentication
        print("Sign in button action")
    }
    
    private let createAccountPageText = "CREATE ACCOUNT"
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LoginView()
}
