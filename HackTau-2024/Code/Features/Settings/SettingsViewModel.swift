//
//  SettingsViewController.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile(first_name: "John", last_name: "Severson", phone_number: "845-500-0549", username: "MunchMaster69")
    @Published var notificationsEnabled: Bool = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        setupSubscribers()
    }
    
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
