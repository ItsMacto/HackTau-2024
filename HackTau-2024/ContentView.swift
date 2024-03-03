//
//  ContentView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn = false
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isLoggedIn: $isLoggedIn)
        } else {
            CircleMainView()
        }
    }
}
    
#Preview {
    ContentView()
    //SwipeView()
}
