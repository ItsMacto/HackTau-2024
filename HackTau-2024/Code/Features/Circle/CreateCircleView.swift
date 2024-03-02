//
//  CreateCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI

struct CreateCircleView: View {
    @State private var circleCode: String = "GeneratedCode123" // This should be dynamically generated in a real app
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your Circle Code")
                .font(.title)
                .padding(.bottom, 20)
            
            Text(circleCode)
                .font(.title2)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button("Share Code") {
                // Implement share logic here
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}


#Preview {
    CreateCircleView()
}
