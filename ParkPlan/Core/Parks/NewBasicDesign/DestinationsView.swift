//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct DestinationsView: View {
	let disneyWorld = Bundle.main.decode("ParkData.json", as: Resort.self)
	@EnvironmentObject var data: DisneyDataService

	var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(data.disneyWorld.parks) { park in
					NavigationLink {
						#if os(iOS)
						EntitiesListView(park: park)
//						ParkOverviewView()
//							.environmentObject(ParkOverviewViewModel(park: park))
						#elseif os(watchOS)
//						ParkDetailView(park: park, entityType: .attraction)
						EntitiesListView(park: park)
						#endif
					} label: {
						ParkBannerView(park: park)
							.padding(.horizontal)
					}
				}
			}
			.navigationTitle(disneyWorld.name)
		}
	}
}

#Preview {
	DestinationsView()
		.environmentObject(DisneyDataService())
}
