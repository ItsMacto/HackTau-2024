//
//  AccountSettingsViewModel.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import Combine

class ProfileEditorViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var notificationsEnabled: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init(userProfile: UserProfile) {
        self.userProfile = userProfile

            // Subscribe to changes and perform any additional setup
        setupSubscribers()
    }

    func saveChanges() {
    // Perform logic to save changes to the user profile
        // For example, you might call a service to update the user profile on the server
        print("Saving changes: First Name - \(userProfile.first_name), Phone Number - \(userProfile.phone_number)")
    }
// WTF IS THIS JOHN
    private func setupSubscribers() {
    // Optionally, add any subscribers to respond to changes in the data
        $userProfile
            .sink { [weak self] updatedProfile in
                // Handle changes to the name property if needed
                print("User Profile Updated")
            }
                .store(in: &cancellables)
            // Add subscribers for other properties as needed
    }
}
