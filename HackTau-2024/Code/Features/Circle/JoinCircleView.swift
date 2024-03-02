//
//  JoinCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI

struct JoinCircleView: View {
    @State private var code: String = ""
    
    var body: some View {
        VStack {
            Text("Enter the Circle Code")
                .font(.title)
                .padding(.bottom, 20)
            
            TextField("Circle Code", text: $code)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Join Circle") {
                // Implement join logic here
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}


#Preview {
    JoinCircleView()
}
