//
//  LoginModel.swift
//  HackTau-2024
//
//  Created by Alexander Korte on 3/2/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var navigateToCircleMainView = false

    func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { [unowned self] result, error in guard error == nil else {
            self.errorMessage = "Google Sign In Error: \(error!.localizedDescription)"
                return
            }
            
            guard let user = result?.user,
                let idToken = user.idToken?.tokenString
              else { return }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Firebase Authentication Error: \(error.localizedDescription)"
                    return
                }

                guard let firebaseUser = authResult?.user else { return }
                print(firebaseUser.email ?? "NO EMAIL FOUND")
//                self.user = User(id: firebaseUser.uid, email: firebaseUser.email!, displayName: firebaseUser.displayName)
                self.isLoggedIn = true
                self.navigateToCircleMainView = true // Trigger navigation to CircleMainView
            }
        }
    }
    func checkUserAuthentication() {
        if let _ = Auth.auth().currentUser {
            isLoggedIn = true
        }
    }

    
    private func getRootViewController() -> UIViewController {
          guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
              return .init()
          }

          guard let root = screen.windows.first?.rootViewController else {
              return .init()
          }

          return root
      }
}
