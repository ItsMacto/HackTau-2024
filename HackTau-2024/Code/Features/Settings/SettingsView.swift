//
//  SettingsViewModel.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel

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
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settingsViewModel: SettingsViewModel(userProfile: UserProfile(first_name: "John", last_name: "Severson", phone_number: "845-500-0549", username: "MunchMaster69")))
    }
}



