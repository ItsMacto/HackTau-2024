//
//  CreateCircleView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct CreateCircleView: View {
    @State private var circleCode: String = "GeneratedCode123" // Placeholder for dynamically generated code
    @State private var searchText = ""
    @State private var region = MKCoordinateRegion() // Initialized empty, will be set onAppear
    @State private var showingCity = "Loading..."
    @StateObject private var locationManager = LocationManager()

    @State private var members = ["Alice", "Bob", "Charlie"] // Example list of members

    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                HStack {
                    Text(circleCode)
                        .font(.title2)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                    Button(action: {
                        // Implement share logic here, e.g., share sheet
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            
                Text("Showing restaurants for: \(showingCity)")
                
                HStack {
                    TextField("Search Address", text: $searchText, onCommit: {
                        geocodeAddressString(searchText)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                    Button(action: {
                        fetchCurrentLocation()
                    }) {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.trailing)
                    }
                }

                Text("Circle Members")
                    .font(.headline)
                    .padding(.top, 20)
                
                ForEach(members, id: \.self) { member in
                    Text(member)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            fetchCurrentLocation()
        }
    }

    private func fetchCurrentLocation() {
        locationManager.onLocationUpdate = { location in
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                self.updateRegionAndCity(from: location)
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
    var onLocationUpdate: ((CLLocation) -> Void)? // Callback for location updates

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            onLocationUpdate?(location) // Call the callback with the new location
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
    

