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
        Button(action: action) {
            HStack {
                Image("GoogleLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                
                Text("Sign in with Google")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
        }
    }
}

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Binding var isLoggedIn: Bool

    var body: some View {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Munch")
                    .font(.custom("Fredoka One", size: 100))
                    .foregroundColor(.primaryAccent.opacity(1))
                    .bold()
                
                Image("MunchLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .padding()
                
                GoogleSignInButton(action: {
                    viewModel.googleSignIn()
                })
                .padding(.horizontal)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                if viewModel.isLoggedIn {
                    Text("LOGGED IN")
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [.primaryProduct, .secondaryProduct]), startPoint: .top, endPoint: .bottom))
        .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
                    self.isLoggedIn = newValue
        }
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
