//
//  LoginView.swift
//  HackTau-2024
//
//  Created by Alexander Korte on 3/2/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Image("YourAppLogo") // Replace with your app's logo image
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("Welcome Back")
                .font(.largeTitle)
.fontWeight(.semibold)

            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(5)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.15))
                .cornerRadius(5)

            Button("Login") {
                // Handle login logic here (e.g., authenticate with a server)
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .cornerRadius(10)

            Spacer() // Pushes content to the top
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
