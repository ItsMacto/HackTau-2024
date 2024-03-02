//
//  MapView.swift
//  HackTau-2024
//
//  Created by Mac Howe  on 3/2/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        // UIView creation logic...
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // UIView update logic...
    }
}

// Preview for development purposes
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: .constant(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )))
    }
}

#Preview {
    MapView(region: .constant(MKCoordinateRegion(
               center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
               span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))))
}
