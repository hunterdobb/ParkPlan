//
//  ParksList.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/1/23.
//

import SwiftUI

struct ParksList: View {
    let destination: DestinationEntry

    var body: some View {
        Section {
            ForEach(destination.parks) { park in
                NavigationLink(park.name) {
					#if os(iOS)
					// Pass in DestinationParkEntry
					// ParkOverviewView(park: park)
//					ParkOverviewView(parkId: park.id, parkName: park.name)
					ParkOverviewView()
						.environmentObject(ParkOverviewViewModel(park: park))
					#elseif os(watchOS)
					ParkDetailView(park: park, entityType: .attraction)
//					ParkDetailView(parkId: park.id, entityType: .attraction)
					#endif
                }
            }
        } header: {
            if destination.parks.count > 1 {
                Text(destination.name)
            }
        }
    }
}

struct ParksListView_Previews: PreviewProvider {
    static var previewDestination: DestinationEntry {
       let destination = try! StaticJSONMapper.decode(file: "DestinationsStaticData", type: DestinationsResponse.self)
        return destination.destinations.first!
    }

    static var previews: some View {
        List {
            ParksList(destination: previewDestination)
        }
    }
}
