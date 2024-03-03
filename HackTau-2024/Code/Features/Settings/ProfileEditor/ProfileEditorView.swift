//
//  AcountSettingsView.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import SwiftUI

struct ProfileEditorView: View {
    @ObservedObject var viewModel: ProfileEditorViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isSaveButtonClicked = false
    @State private var isImagePickerPresented = false
    @State private var isChoosingSource = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                // Profile Picture Section
                Section(header: Text("Profile Picture")) {
                    HStack {
                        if let profilePicture = viewModel.userProfile.profilePicture {
                            Image(uiImage: profilePicture)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        
                        Spacer()
                        
                        Text("Edit Profile Picture")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                            .sheet(isPresented: $isImagePickerPresented) {
                                ImagePickerView(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented, sourceType: .photoLibrary)
                            }
                    }
                }
                Section(header: Text("Profile Information")) {
                    TextField("First Name", text: $viewModel.userProfile.first_name)
                    TextField("Last Name", text: $viewModel.userProfile.last_name)
                    TextField("Phone Number", text: $viewModel.userProfile.phone_number)
                    TextField("Username", text: $viewModel.userProfile.username)
                }
                Section {
                    Button(action: {
                        viewModel.saveChanges()
                        isSaveButtonClicked = true
                    }) {
                        Text("Save Changes")
                    }
                    .foregroundColor(isSaveButtonClicked ? .gray : .blue)
                    .disabled(isSaveButtonClicked)
                }
                
            }
            .navigationTitle("Edit Profile")
        }
    }
}

struct ProfileEditorView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample UserProfile instance
        let sampleUserProfile = UserProfile(
            first_name: "John",
            last_name: "Doe",
            phone_number: "123-456-7890",
            username: "john_doe"
            // Add other properties as needed
        )

        // Pass the sample UserProfile to the ProfileEditorViewModel
        let viewModel = ProfileEditorViewModel(userProfile: sampleUserProfile)

        // Pass the viewModel to the ProfileEditorView
        return ProfileEditorView(viewModel: viewModel)
    }
}
