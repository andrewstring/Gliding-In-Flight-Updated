//
//  LoginView.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/20/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var gliderStore: GliderStore
    
    private let signInButtonText = "SIGN IN"
    private func signInButtonAction() {
        // TEMPORARY FOR TESTING
        Task {
            let glider = Glider(
                id: username,
                name: username
            )
            do {
                try await gliderStore.gliderSave(glider: glider)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private let createAccountPageText = "CREATE ACCOUNT"
    private func createAccountButtonAction() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login").font(.system(.largeTitle))
                    .padding(.bottom, 20.0)
                
                Label("Username", systemImage: "person.fill")
                TextField("Username", text: $username, prompt: Text("Required"))
                    .padding(.bottom, 20.0)
                
                Label("Password", systemImage: "lock.fill")
                TextField("Password", text: $password, prompt: Text("Required"))
                    .padding(.bottom, 20.0)
                
                HStack {
                    Button("Sign In", action: signInButtonAction)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(10.0)
                        .background(.gray)
                        .cornerRadius(10.0)
                    NavigationLink(destination: CreateAccountView()) {
                        Text("Create Account")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(10.0)
                            .background(.gray)
                            .cornerRadius(10.0)
                    }
                }
                
            }
            .multilineTextAlignment(.center)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

#Preview {
    LoginView()
}
