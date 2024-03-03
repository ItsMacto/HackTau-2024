//
//  SettingsViewController.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile()
    @Published var notificationsEnabled: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init(userProfile: UserProfile) {
        self.userProfile = userProfile

        // Subscribe to changes and perform any additional setup
        setupSubscribers()
    }

    private func setupSubscribers() {
        // Optionally, add any subscribers to respond to changes in the data
        $userProfile
            .compactMap { $0.first_name }
            .sink { [weak self] newName in
                // Handle changes to the name property if needed
                print("Name changed to: \(newName)")
            }
            .store(in: &cancellables)
        // Add subscribers for other properties as needed
    }
}
