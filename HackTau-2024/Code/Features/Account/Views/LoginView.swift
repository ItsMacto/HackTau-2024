//
//  LoginView.swift
//  HackTau-2024
//
//  Created by Alexander Korte on 3/2/24.
//

import SwiftUI

struct GoogleSignInButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(width: 40, height: 40)
                Image("GoogleLogo") // Replace with your Google logo image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }

            Spacer()

            Text("Sign in with Google")
                .font(.headline)
                .foregroundColor(.white)

            Spacer()
        }
        .padding(10)
        .background(Color.blue)
        .cornerRadius(8)
        .onTapGesture {
            action()
        }
    }
}

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()

    var body: some View {
        VStack {
            Image("your_app_logo") // Replace with your app logo
                .resizable()
                .scaledToFit()
                .padding()

            GoogleSignInButton(action: {
                viewModel.googleSignIn()
            })

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
