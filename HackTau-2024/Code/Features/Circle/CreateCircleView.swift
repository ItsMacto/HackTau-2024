//
//  CreateCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI
import MapKit
import CoreLocation
import Firebase


struct CreateCircleView: View {
    let functions = Functions.functions()

    @State private var circleCode: String = "" //TODO: Placeholder for dynamically generated code
    @State private var searchText = ""
    @State private var region = MKCoordinateRegion()
    @State private var showingCity = "Loading..."
    @StateObject private var locationManager = LocationManager()

    @State private var members = ["Alice", "Bob", "Charlie"] // TODO: static list of members
    @State private var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                HStack {
                    Text("Circle: \(circleCode)")
                        .font(.custom("Fredoka One", size: 30))
                        
                        .padding()
                        .background(Color.secondaryBackground)
                        .foregroundColor(.primaryBackground)
                        .cornerRadius(10)

                    Button(action: {
                        self.showingShareSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding()
                        

                    }
                    .background(Color.secondaryBackground)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .sheet(isPresented: $showingShareSheet) {
                                ShareSheet(items: ["Join our circle: \(self.circleCode)"])
                            }
                }
            
                Text("Showing restaurants for: ")
                    .foregroundColor(Color.primaryBackground) +
                Text(showingCity)
                    .foregroundColor(.primaryProduct).bold()
                
                
                HStack {
                    TextField("Search Address", text: $searchText, onCommit: {
                        geocodeAddressString(searchText)
                    })
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(15)
                    .padding(.horizontal)
                   
                    Button(action: {
                        fetchCurrentLocation()
                    }) {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing)
                            .foregroundColor(.secondaryBackground)
                    }
                }

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
            .padding()
        }
        .onAppear {
            fetchCurrentLocation()
            createCircle ()
        }
        .background(Gradient(colors: [.secondaryAccent,.primaryAccent]).opacity(0.7))
    }

    private func fetchCurrentLocation() {
        locationManager.onLocationUpdate = { location in
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                self.updateRegionAndCity(from: location)
                self.updateCityName(from: location)
            }
        }
        locationManager.requestLocation()
    }

    private func updateRegionAndCity(from location: CLLocation?) {
        guard let location = location else { return }
        let newRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.region = newRegion
        updateCityName(from: location)
    }

    private func updateCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placemark = placemarks?.first, error == nil {
                self.showingCity = placemark.locality ?? "Unknown"
            }
        }
    }
    
    private func geocodeAddressString(_ addressString: String) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
                if let location = placemarks?.first?.location {
                    updateRegionAndCity(from: location)
                }
            }
        }
}
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationAuthorization()
    }

    private func requestLocationAuthorization() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func requestLocation() {
        requestLocationAuthorization() // Ensure we have authorization every time we request location
        locationManager.startUpdatingLocation() // Start updates to get the latest location
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last { // Use the most recent location
            onLocationUpdate?(location)
            locationManager.stopUpdatingLocation() //Stops updates/ continuous tracking
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}


struct CreateCircleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCircleView()
    }
}


struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


private func createCircle() {
       guard let userID = Auth.auth().currentUser?.uid else {
           print("User not logged in")
           return
       }
       
       functions.httpsCallable("createCircle").call(["userId": userID]) { result, error in
           if let error = error as NSError? {
               print("Error calling createCircle: \(error.localizedDescription)")
           } else if let circleId = result?.data as? String {
               DispatchQueue.main.async {
                   self.circleCode = circleId
               }
           }
       }
   }

