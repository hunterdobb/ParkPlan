//
//  ParksList.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/1/23.
//

import SwiftUI

/*
struct ParksList: View {
    let destination: DestinationEntry

    var body: some View {
        Section {
            ForEach(destination.parks) { park in
                NavigationLink(park.name) {
					#if os(iOS)
					ParkOverviewView()
						.environmentObject(ParkOverviewViewModel(park: destination.parks))
					#elseif os(watchOS)
					ParkDetailView(data: data, entityType: .attraction)
					#endif
                }
            }
        } header: {
            if destination.parks.count > 1 {
                VStack {
                	Text(destination.name)
                }
            }
        }
    }
}

#Preview {
	NavigationStack {
		List {
			ParksList(destination: .preview)
		}
	}
}
*/
