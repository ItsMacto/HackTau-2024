//
//  ContentView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

        var body: some View {
            if isLoggedIn {
                CircleMainView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
}
    
#Preview {
    ContentView()
    //SwipeView()
}
