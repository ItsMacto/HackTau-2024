//
//  ImagePickerView.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.selectedImage = info[.editedImage] as? UIImage ?? parent.selectedImage
            parent.isImagePickerPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isImagePickerPresented = false
        }
    }
}
struct GrayProfileIcon: View {
        var body: some View {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .foregroundColor(Color.gray.opacity(0.7)) // Adjust the opacity as needed
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
}

