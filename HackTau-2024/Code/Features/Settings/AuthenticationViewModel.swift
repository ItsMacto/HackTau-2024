//
//  AuthenticationViewModel.swift
//  HackTau-2024
//
//  Created by John Severson on 3/3/24.
//

import Foundation
import Firebase
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
