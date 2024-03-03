import SwiftUI

struct SwipeView: View {
 struct Restaurant: Identifiable {
     var id: Int
     var image: String
     var name: String
     var offset: CGFloat = 0
     var x: CGFloat = 0.0
     var y: CGFloat = 0.0
     var degree: Double = 0.0
     var isLiked: Bool = false
 }
  @State private var gestureEnabled = true

  @State var likedRestaurants: [Restaurant] = []
  @State var restaurants = [
      Restaurant(id: 0, image: "https://upload.wikimedia.org/wikipedia/commons/2/25/New-McDonald-HU-lg_%2843261171540%29.jpg", name: "McDonalds"),
      Restaurant(id: 1, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1280px-Burger_King_2020.svg.png", name: "Burger King"),
      Restaurant(id: 2, image: "https://upload.wikimedia.org/wikipedia/en/thumb/8/85/Panda_Express_logo.svg/1920px-Panda_Express_logo.svg.png", name: "Panda Express")
  ]
  
  var body: some View{
      VStack{
          //Top Stack
          ZStack{
              Color(.secondaryProduct)
                  .frame(width:400, height: 200)
                  .offset(y:-75)
              HStack(spacing: 0){
                  Button(action:{}) {
                      Image(systemName: "gearshape.fill")
                          .resizable()
                          .shadow(radius: 5)
                          .frame(width: 60, height: 60)
                          .offset(y: -20)
                          .offset(x: 20)
                          .foregroundColor(.secondaryBackground)
                  }
                  Spacer()
                  
                  Image("MunchLogo")
                      .resizable()
                      .shadow(radius: 5)
                      .frame(width:100, height: 100)
                      .offset(y: -10)
                      .padding(.bottom)
                  Spacer()
                  Button(action: {}){
                      Image(systemName: "person.crop.circle.fill")
                          .resizable()
                          .shadow(radius: 5)
                          .frame(width: 55, height: 55)
                          .offset(y: -10)
                          .offset(x: -25)
                  }
                    .padding(.bottom)
                      .foregroundColor(.secondaryBackground)
              }
          }
          
          .padding(.horizontal)
          Spacer()
          //Middle Stack
          ZStack {
              ForEach(restaurants.reversed()) { restaurant in
                  CardView(restaurant: restaurant, onLike: {
                      self.likeRestaurant(restaurant)
                  })
              }.zIndex(1.0)
          }
          //button stack
          HStack(alignment: .center, spacing: 70){
              Button(action: {
                  withAnimation {
                      swipeCard(direction: .right, restaurants: &self.restaurants) { restaurant in
                      }
                }
              }){
                  Image("dismiss_circle")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .shadow(radius: 5)
                      .frame(height: 90)
              }
              
              .padding(.bottom, 150)
              Button(action: {
                  withAnimation {
                      swipeCard(direction: .right, restaurants: &self.restaurants) { restaurant in
                          // Handle liked restaurant
                          self.likedRestaurants.append(restaurant)
                          print("Liked Restaurant ID: \(restaurant.id)")
                      }
                  }
              }){
                  Image("like_circle")
                      .resizable()
                      .aspectRatio(contentMode: .fit)
                      .shadow(radius: 5)
                      .frame(height: 90)
              }
              .padding(.bottom, 150)
          }//Like and dislike button
      }
      .padding(.top)
      .background(.secondaryProduct)
  }
    func likeRestaurant(_ restaurant: Restaurant) {
        if let index = restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            likedRestaurants.append(restaurants[index])
        }
    }
}
func swipeCard(direction: SwipeDirection, restaurants: inout [SwipeView.Restaurant], onLiked: (SwipeView.Restaurant) -> Void) {
    withAnimation {
        if direction == .right {
            // Call onLiked closure with the first restaurant
            if let firstRestaurant = restaurants.first {
                onLiked(firstRestaurant)
            }
        }
        restaurants.removeFirst()
    }
}

enum SwipeDirection {
    case left
    case right
}
 struct SwipeView_Previews: PreviewProvider {
     static var previews: some View {
         SwipeView()
     }
 }

struct CardView: View {
 @State var restaurant: SwipeView.Restaurant
 let restaurantGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    var onLike: () -> Void
 var body: some View {
     ZStack(alignment: .topLeading){
         Image("McDonalds")//needs to be Image(restaurant.image)
             .resizable()
             .frame(width: 360, height: 360)
             .cornerRadius(10)
             .padding(.bottom)
             //.offset(y: 10)
        //LinearGradient(gradient: restaurantGradient, startPoint: .top, endPoint: .bottom)
         VStack(){
             Text(restaurant.name)
                 .font(.largeTitle)
                 .fontWeight(.bold)
                 .padding(.bottom, 100)
                 .foregroundColor(.white)
                 .offset(y: 320)
             Spacer()
         }
         
         HStack{
             Image("like")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: 150)
                 .opacity(Double(restaurant.x/10 - 1))
                 .onTapGesture {
                     self.onLike()
                 }
             Image("nope")
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: 150)
                 .opacity(Double(restaurant.x/10 * -1 - 1))
                 .offset(x: 50)
         }
     }
     .padding(.top, 40)
     .cornerRadius(8)
     .offset(x: restaurant.x, y: restaurant.y)
     .rotationEffect(.init(degrees: restaurant.degree))
     .gesture(
         DragGesture()
             .onChanged{ value in
                 withAnimation(.default){
                     restaurant.x = value.translation.width
                     restaurant.y = value.translation.height
                     restaurant.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                 }
                 
             }
             .onEnded{ value in
                 withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)){
                     switch value.translation.width{
                     case 0...100:
                         restaurant.x = 0; restaurant.degree = 0; restaurant.y = 0
                     case let x where x > 100:
                         restaurant.x = 500; restaurant.degree = 12;
                     case (-100)...(-1):
                         restaurant.x = 0; restaurant.degree = 0; restaurant.y = 0;
                     case let x where x < -100:
                         restaurant.x = -500; restaurant.degree = -12;
                     default: restaurant.x = 0; restaurant.y = 0
                     }
                 }
                 
             }
         
     )
 }
}
