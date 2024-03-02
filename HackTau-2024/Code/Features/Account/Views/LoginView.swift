//
//  LoginView.swift
//  HackTau-2024
//
//  Created by Alexander Korte on 3/2/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            Image("your_app_logo") // Replace with your app logo
                .resizable()
                .scaledToFit()
                .padding()

            Button("Sign in with Google") {
                viewModel.googleSignIn()
            }
            .buttonStyle(.borderedProminent)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle("Login")
    }
}

#Preview {
    LoginView()
}
