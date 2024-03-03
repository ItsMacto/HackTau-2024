//
//  JoinCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//
//
//  JoinCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//
import SwiftUI
import Firebase
import FirebaseFunctions
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct JoinCircleView: View {
    @State private var circleCode: String = ""
    @State private var failedToJoin: Bool = false
    @State private var didJoin: Bool = false
    @State private var members = ["Alice", "Bob", "Charlie"]
    @State private var goToSwipeView = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.secondaryAccent, .primaryAccent]), startPoint: .top, endPoint: .bottom)
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 20) {
                Text("Enter the Circle Code")
                    .font(.custom("Fredoka One", size: 40))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.secondaryBackground)

                TextField("Circle Code", text: $circleCode)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.horizontal)

                if !didJoin {
                    Button("Join Circle") {
                        joinCircle()
                    }
                    .padding()
                    .background(Color.secondaryBackground)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Text("Circle Members")
                        .font(.headline)
                        .padding(.top, 20)
                        .bold()
                    
                    ForEach(members, id: \.self) { member in
                        Text(member)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                    }
                }
                
                NavigationLink(destination: SwipeView(), isActive: $goToSwipeView) {
                    EmptyView()
                }
                Spacer() // Pushes everything to the top
            }
            .padding()
            .frame(maxWidth: .infinity)
            .alert(
                "Failed to join Circle",
                isPresented: $failedToJoin
            ) {
                Button("OK") {
                    self.failedToJoin = false
                }
            }
        }
    }
    
    private func joinCircle() {
            let functions = Functions.functions()
        
           guard let userID = Auth.auth().currentUser?.uid else {
               print("User not logged in")
               return
           }
           
            print("USER ID: \(userID)")
        let data = ["userId": userID, "circleId": self.circleCode] as [String: String]
        functions.httpsCallable("joinCircle").call(data) { result, error in
               if let error = error as NSError? {
                   print("Error calling createCircle: \(error)")
               } else if ((result?.data) != nil) { // Now you can safely subscript
                          DispatchQueue.main.async {
                              self.didJoin = true
                              observeDocument()
                          }
                      } else {
                          // Handle the case where `circleId` is not found or `result?.data` cannot be cast to `[String: Any]`
                          print("circleId not found or data is not a dictionary")
                          self.failedToJoin = true
                      }
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
            
            guard let status = data["status"] as? String else {
                return
            }
            
            if status == "active" {
                self.goToSwipeView = true
            }
            
            guard let members = data["members"] as? [[String: Any]] else {
                return
            }
            
            let membersUnwrapped = members.map { memberDict in
                guard let username = memberDict["username"] as? String else {
                    // Handle the case where a member doesn't have a username
                    return "Unknown Username"
                }
                
                return username
            }


            self.members = membersUnwrapped
        }
    }
}

// Preview
struct JoinCircleView_Previews: PreviewProvider {
    static var previews: some View {
        JoinCircleView()
    }
}
