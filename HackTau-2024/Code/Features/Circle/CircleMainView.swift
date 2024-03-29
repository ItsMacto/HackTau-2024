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
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Join or Create a Circle!")
                        .font(.custom("Fredoka One", size: 40))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.secondaryBackground)
                    
                    // Buttons container
                    VStack(spacing: 20) {
                        NavigationLink(destination: JoinCircleView()) {
                            Text("Join")
                                .font(.title2)
                                .frame(minWidth: 0, maxWidth: 150)
                                .padding()
                                .background(Color.secondaryBackground)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        NavigationLink(destination: CreateCircleView()) {
                            Text("Create")
                                .font(.title2)
                                .frame(minWidth: 0, maxWidth: 150)
                                .padding()
                                .background(Color.secondaryBackground)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                    .frame(maxWidth: 300) 
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
