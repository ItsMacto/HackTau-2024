//
//  SettingsViewModel.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import SwiftUI

struct SignOutConfirmationSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var authenticationViewModel: AuthenticationViewModel

    var body: some View {
        VStack {
            Text("Are you sure you want to sign out?")
                .padding()
            Button("Sign Out") {
                authenticationViewModel.signOut { result in
                    if case .success = result {
                        presentationMode.wrappedValue.dismiss()
                    } else if case .failure(let error) = result {
                        print("Failed to sign out: \(error)")
                    }
                }
            }
            .foregroundColor(.red)
            .padding()
        }
    }
}

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel = SettingsViewModel()
    @StateObject var authenticationViewModel: AuthenticationViewModel = AuthenticationViewModel()
    @State private var showingSignOutConfirmation = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General Settings")) {
                    Toggle("Enable Notifications", isOn: $settingsViewModel.notificationsEnabled)
                }

                Section(header: Text("Account")) {
                    NavigationLink(destination: ProfileEditorView(viewModel: ProfileEditorViewModel(userProfile: settingsViewModel.userProfile))) {
                        Text("Edit Profile")
                    }
                    .foregroundColor(.blue)
                    Button(action: {
                        showingSignOutConfirmation = true
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $showingSignOutConfirmation, content: {
            SignOutConfirmationSheet(authenticationViewModel: authenticationViewModel)
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModel: SettingsViewModel(userProfile: UserProfile(first_name: "John", last_name: "Severson", phone_number: "845-500-0549", username: "MunchMaster69")))
    }
}



