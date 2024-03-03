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
    }
    
    @State var restaurants = [
        Restaurant(id: 0, image: "https://upload.wikimedia.org/wikipedia/commons/2/25/New-McDonald-HU-lg_%2843261171540%29.jpg", name: "McDonalds"),
        Restaurant(id: 1, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1280px-Burger_King_2020.svg.png", name: "Burger King"),
        Restaurant(id: 2, image: "https://upload.wikimedia.org/wikipedia/en/thumb/8/85/Panda_Express_logo.svg/1920px-Panda_Express_logo.svg.png", name: "Panda Express")
    ]
    
    var body: some View{
        VStack{
            HStack(spacing: 0){
                Button(action: {}){
                    Image("Settings")
                        .resizable()
                        .frame(width: 60, height: 60)
                }.padding(.bottom, 80)
                Spacer()
                Button(action: {}){
                    Image("top_left_profile")
                        .resizable()
                        .frame(width: 60, height: 60)
                }.padding(.bottom, 80)
            }
            .padding(.horizontal)
            Spacer()
            ZStack{
                Image("BurgerKing")
                    .resizable()
                    .frame(width: 360, height: 360)
                VStack{
                    VStack{
                        HStack{
                            ForEach(restaurants.indices) { index in
                               let restaurant = restaurants[index]
                                
                        }
                    }
                }
            }.padding(.top, 40)
            HStack{
                Button(action: {}){
                    Image("dismiss_circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 5)
                        .frame(height: 90)
                }

                .padding(.bottom, 150)
                Button(action: {}){
                    Image("like_circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 5)
                        .frame(height: 90)
                }
                .padding(.bottom, 150)
            }//Like and dislike button
            
        }
    }
}
     /*@State var activeCardIndex = 0
     
     var body: some View {
     VStack {
     Spacer()
     ZStack {
     ForEach(restaurants.indices) { index in
     let restaurant = restaurants[index]
     let cardOffset = CGFloat(index - activeCardIndex) * 20
     
     if index == activeCardIndex {
     AsyncImage(url: URL(string: restaurant.image)) { phase in
     switch phase {
     case .empty:
     ProgressView()
     case .success(let image):
     image.resizable()
     .aspectRatio(contentMode: .fill)
     .frame(width: UIScreen.main.bounds.width - 40, height: 400)
     .cornerRadius(15)
     //.shadow(radius: 10)
     .offset(x: restaurant.offset)
     .gesture(DragGesture().onChanged { value in
     withAnimation {
     self.restaurants[index].offset = value.translation.width
     }
     }.onEnded { value in
     withAnimation {
     if value.translation.width < -100 && index < self.restaurants.count - 1 {
     self.restaurants[index].offset = -((UIScreen.main.bounds.width - 40) + 20)
     self.activeCardIndex += 1
     } else if value.translation.width > 100 && index > 0 {
     self.restaurants[index].offset = (UIScreen.main.bounds.width - 40) + 20
     self.activeCardIndex += 1  // Change this line to increment activeCardIndex
     } else {
     self.restaurants[index].offset = 0
     }
     }
     })
     case .failure(let error):
     Image(systemName: "photo")
     @unknown default:
     EmptyView()
     }
     }
     .padding(.bottom, cardOffset)
     .zIndex(Double(-index))
     
     Text(restaurant.name)
     .font(.system(size: 40))
     .foregroundColor(.black)
     .frame(maxHeight: 500, alignment: .bottom)
     }
     }
     .padding(.bottom)
     .cornerRadius(/*@START_MENU_TOKEN@*/8.0/*@END_MENU_TOKEN@*/)
     }
     Spacer()
     if activeCardIndex >= restaurants.count {
     Text("All out of Restaurants!")
     .font(.title)
     .foregroundColor(.black)
     .padding()
     }else {
     EmptyView()
     }
     }
     .padding()
     }
     }
     */
    struct SwipeView_Previews: PreviewProvider {
        static var previews: some View {
            SwipeView()
        }
    }
