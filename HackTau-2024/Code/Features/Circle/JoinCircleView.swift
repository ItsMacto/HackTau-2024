//
//  JoinCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//
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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.secondaryAccent, .primaryAccent]), startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 20) {
                Text("Enter the Circle Code")
                    .font(.custom("Fredoka One", size: 40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.secondaryBackground)

                TextField("Circle Code", text: $code)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.horizontal)

                Button("Join Circle") {
                    // TODO: Implement join logic here
                }
                .padding()
                .background(Color.secondaryBackground)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer() // Pushes everything to the top
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
}

// Preview
struct JoinCircleView_Previews: PreviewProvider {
    static var previews: some View {
        JoinCircleView()
    }
}
