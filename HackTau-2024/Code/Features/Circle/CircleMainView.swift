//
//  CircleMainView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//
import SwiftUI
import MapKit

struct CircleMainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [.secondaryAccent, .primaryAccent]), startPoint: .top, endPoint: .bottom)
                                    .opacity(0.5)
                                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Join or Create a circle")
                        .font(.custom(<#T##name: String##String#>, size: <#T##CGFloat#>))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink(destination: JoinCircleView()) {
                        Text("Join a Circle")
                            .font(.title2)
                            .padding()
                            .background(Color.secondaryBackground)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: CreateCircleView()) {
                        Text("Create a Circle")
                            .font(.title2)
                            .padding()
                            .background(Color.secondaryBackground)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// Preview
struct CircleMainView_Previews: PreviewProvider {
    static var previews: some View {
        CircleMainView()
    }
}
