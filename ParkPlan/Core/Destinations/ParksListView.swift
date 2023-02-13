//
//  ParksListView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/1/23.
//

import SwiftUI

struct ParksListView: View {
    let destination: DestinationEntry

    var body: some View {
        Section {
            ForEach(destination.parks) { park in
                NavigationLink(park.name) {
//                    ParkView(parkId: park.id)
//					ParkDataView(parkId: park.id)
					#if os(iOS)
					ParkOverviewView(parkId: park.id, parkName: park.name)
					#elseif os(watchOS)
					ParkDataView(parkId: park.id, entityType: .attraction)
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
            ParksListView(destination: previewDestination)
        }
    }
}
