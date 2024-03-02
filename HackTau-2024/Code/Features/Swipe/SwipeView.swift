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
        Restaurants(id: 0, image: "https://upload.wikimedia.org/wikipedia/commons/2/25/New-McDonald-HU-lg_%2843261171540%29.jpg", name: "McDonalds"),
        Restaurants(id: 1, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1280px-Burger_King_2020.svg.png", name: "Burger King")
    ]
    @State var move = 0
    var body: some View {
        VStack {
            ForEach(restaurants) { restaurant in
                let imageWidth = (UIScreen.main.bounds.width - 50) - 60
                let imageHeight = (UIScreen.main.bounds.height / 2) - CGFloat(restaurant.id - move) * 40
                let offsetX = restaurant.id - move <= 2 ? CGFloat(restaurant.id - move) * 20 : 60
                
                ZStack {
                    AsyncImage(url: URL(string: restaurant.image)) {
                        phase in switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: imageWidth, height: imageHeight)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                                .offset(x: offsetX)
                        case .failure(let error):
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    
                    Text("Restaurant Name: \(restaurant.name) ")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    
    struct SwipeView_Previews: PreviewProvider {
        static var previews: some View {
            SwipeView()
        }
    }
}
