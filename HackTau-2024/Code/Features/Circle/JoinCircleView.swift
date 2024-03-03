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
    @State private var code: String = ""

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

                TextField("Circle Code", text: $code)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.horizontal)

                Button("Join Circle") {
                    // TODO: Implement join logic here
                }
                .padding()
                .background(Color.secondaryBackground)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer() // Pushes everything to the top
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
    }
    
    private func createCircle() {
            let functions = Functions.functions()
        
           guard let userID = Auth.auth().currentUser?.uid else {
               print("User not logged in")
               return
           }
           
            print("USER ID: \(userID)")
        let data = ["userId": userID] as [String: String]
        functions.httpsCallable("createCircle").call(data) { result, error in
               if let error = error as NSError? {
                   print("Error calling createCircle: \(error)")
               } else if let data = result?.data as? [String: Any], // Cast `result?.data` to a dictionary
                         let circleId = data["circleId"] as? String { // Now you can safely subscript
                          print("CIRCLE ID: \(circleId)")
                          DispatchQueue.main.async {
                              self.circleCode = circleId
                              observeDocument();
                          }
                      } else {
                          // Handle the case where `circleId` is not found or `result?.data` cannot be cast to `[String: Any]`
                          print("circleId not found or data is not a dictionary")
                      }
           }
       }
    
    func observeDocument() {
        let db = Firestore.firestore()
        var listener: ListenerRegistration?
        
        let docRef = db.collection("circles").document(self.circleCode)

        listener = docRef.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            print("Current data: \(data)")
            
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
