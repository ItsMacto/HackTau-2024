//
//  Splash Screeen View.swift
//  HackTau-2024
//
//  Created by John Severson on 3/2/24.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isLoaded = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    var body: some View {
        ZStack {
            // Your splash screen content
            VStack {
                Image("MunchLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .scaleEffect(size)
                    .opacity(opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 255/255, green: 87/255, blue: 51/255)) // Custom background color
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                withAnimation(.easeIn(duration: 4)) {
                    self.size = 1.5
                    self.opacity = 3
                }
            }
            
            // Your main content, hidden initially
            if isLoaded {
                ContentView()
            }
        }
        .onAppear {
            // Simulate app loading process
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                // After the app is loaded, show the main content
                withAnimation {
                    self.isLoaded = true
                }
            }
        }
    }
}


struct SplashSreenView_Preview : PreviewProvider {
    static var previews: some View{
        SplashScreenView()
    }
}
