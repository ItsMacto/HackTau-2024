import SwiftUI
import Firebase
import FirebaseFirestore

struct RankedRestaurant: Identifiable {
    let id = UUID()
    var rank: Int
    var image: String
    var name: String
}

struct RankingView: View {
    @State var circleCode: String
    @State var rankedRestaurants = [
        RankedRestaurant(rank: 1, image: "https://upload.wikimedia.org/wikipedia/commons/2/25/New-McDonald-HU-lg_%2843261171540%29.jpg", name: "McDonald's"),
        RankedRestaurant(rank: 2, image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1280px-Burger_King_2020.svg.png", name: "Burger King"),
        RankedRestaurant(rank: 3, image: "https://upload.wikimedia.org/wikipedia/en/thumb/8/85/Panda_Express_logo.svg/1920px-Panda_Express_logo.svg.png", name: "Panda Express"),
        RankedRestaurant(rank: 4, image: "https://www.google.com/url?sa=i&url=https%3A%2F%2Flocations.kfc.com%2Fsc%2Fclemson&psig=AOvVaw3m3DaNpxUhpWLSgO_gZ5Ee&ust=1709539380183000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCPjW6c3Q14QDFQAAAAAdAAAAABAE", name: "KFC"),
        RankedRestaurant(rank: 5, image: "https://scontent-atl3-1.xx.fbcdn.net/v/t39.30808-1/294901227_345976441067569_4320901421960067677_n.png?stp=c14.0.480.480a_dst-png_p480x480&_nc_cat=110&ccb=1-7&_nc_sid=4da83f&_nc_ohc=rblHB91aCtUAX8n6QFR&_nc_ht=scontent-atl3-1.xx&oh=00_AfB31OyEXoxPSvM-CkH_0ySkxkHf6YqU1YoxS0fjThOC3A&oe=65E8A217", name: "Subway")
    ]

    var body: some View {
        ZStack {
                    
            Color(.secondaryBackground)
                        .edgesIgnoringSafeArea(.all)

                    VStack(alignment: .center, spacing: 20) {
                        Text("Rankings")
                            .font(.custom("Fredoka One", size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.primaryBackground)

                        List(rankedRestaurants) { restaurant in
                            HStack {
                                Text("#\(restaurant.rank)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(width: 36)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 12)
                                    .cornerRadius(8)
                                    .foregroundColor(.secondaryBackground).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                                AsyncImage(url: URL(string: restaurant.image)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)

                                Text(restaurant.name)
                                    .font(.body)
                            }.cornerRadius(8)
                            .listRowBackground(Color.clear)
                        }
                        .background(Color("secondaryBackground"))
//                        .fill(Color.secondaryBackground)
                        .navigationTitle("Top Restaurants")
                    }
            
        }.navigationBarBackButtonHidden()
            .onAppear() {
                observeDocument()
            }
        
    }
    
    func observeDocument() {
        let db = Firestore.firestore()
        var listener: ListenerRegistration?
        
        let docRef = db.collection("circles").document(self.circleCode.lowercased())

        listener = docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            
            guard let restaurants = data["restaurants"] as? [[String: Any]] else {
                return
            }
            
            guard let ranked = data["ranked"] as? [[String: Any]] else {
                return
            }
            
            let sortedRanked = ranked.sorted { (firstDict, secondDict) -> Bool in
                guard let firstRank = firstDict["rating"] as? Int, let secondRank = secondDict["rating"] as? Int else {
                    return false
                }
                return firstRank < secondRank
            }
            
            let rankedResturants = sortedRanked.map { restaurant in
                let id = restaurant["id"]
                let resturant = restaurants.first(where: { $0["id"] as? String == id as? String })
                
                return RankedRestaurant(rank: 0, image: restaurant["photo"] as! String, name: restaurant["displayName"] as! String)
            }


            self.rankedRestaurants = rankedResturants
        }
    }

    
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(circleCode: "sbjli")
    }
}

