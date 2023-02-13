//
//  MapTestView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/1/23.
//

import MapKit
import SwiftUI

struct MapTestView: View {
    let center = CLLocationCoordinate2D(
        latitude: 28.4160036778,
        longitude: -81.5811902834
    )

    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 28.4160036778,
            longitude: -81.5811902834),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(alignment: .topTrailing) {
                    Button {
                        withAnimation {
                            region.center = center
                            region.span = span
                        }
                    } label: {
                        Image(systemName: "location.fill.viewfinder")
                            .bold()
                            .padding(8)
                            .background(in: Circle())
                            .backgroundStyle(.blue.gradient)
//                            .foregroundColor(.white)
                            .foregroundStyle(.white)
                    }
                    .controlSize(.large)
                    .labelsHidden()
                    .padding(8)
                    .opacity(region.center.latitude == center.latitude ? 0 : 1)
//                    .disabled(region.center.latitude == center.latitude)
                }


        }
    }
}

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView()
    }
}
