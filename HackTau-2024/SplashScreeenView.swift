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
            
            VStack {
                Text("Munch")
                    .font(.custom("Fredoka One", size: 100))
                    .foregroundColor(.primaryAccent.opacity(1))
                    .bold()
                    .shadow(radius: 5)
                    .opacity(opacity)
                Spacer().frame(height: 20)
                Image("MunchLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                    .padding()
                    .scaleEffect(size)
                    .opacity(opacity)
            }
            .padding(.bottom, 50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.primaryProduct, .secondaryProduct]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                withAnimation(.easeIn(duration: 4)) {
                    self.size = 1.11
                    self.opacity = 3
                }
            }
            
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
