//
//  SettingsViewModel.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import SwiftUI
import Firebase // Import Firebase
import GoogleSignIn

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    @State private var showingSignOutConfirmation = false // State variable for showing confirmation sheet
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

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
                        showingSignOutConfirmation = true // Show confirmation sheet when sign-out button tapped
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $showingSignOutConfirmation, content: {
            SignOutConfirmationSheet()
                .environmentObject(authenticationViewModel) // Inject AuthenticationViewModel
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModel: SettingsViewModel(userProfile: UserProfile(first_name: "John", last_name: "Severson", phone_number: "845-500-0549", username: "MunchMaster69")))
    }
}

// Sign-out confirmation sheet view
struct SignOutConfirmationSheet: View {
    @Environment(\.presentationMode) var presentationMode // Presentation mode to dismiss the sheet
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel // Your authentication view model
    
    var body: some View {
        VStack {
            Text("Are you sure you want to sign out?")
                .padding()
            Button("Sign Out") {
                authenticationViewModel.signOut { result in // Pass an empty completion handler
                    switch result {
                    case .success:
                        presentationMode.wrappedValue.dismiss() // Dismiss the sheet if sign-out succeeds
                    case .failure(let error):
                        print("Failed to sign out: \(error)") // Handle failure if necessary
                    }
                }
            }
            .foregroundColor(.red)
            .padding()
        }
    }
}
