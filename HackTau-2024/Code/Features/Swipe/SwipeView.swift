//
//  SwipeView.swift
//  HackTau-2024
//
//  Created by Alexander Korte on 3/2/24.
//

import SwiftUI

struct SwipeView: View {
    struct Restaurants : Identifiable {
        var id: Int
        var image: String
        var name: String
    }
    @State var restaurants = [
        Restaurants(id: 0, image: "Image1", name: "McDonalds")
    ]
    @State var move = 0
    var body: some View {
        ZStack{
            
        }
    }
}


#Preview {
    SwipeView()
}
