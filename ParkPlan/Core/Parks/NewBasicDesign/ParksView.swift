//
//  ParksView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

struct ParksView: View {
	@EnvironmentObject var disneyDataService: DisneyDataService

	var body: some View {
		NavigationStack {
			ScrollView {
				ForEach(disneyDataService.parks) { park in
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
			.navigationTitle(disneyDataService.resort.name)
		}
	}
}

#Preview {
	ParksView()
		.environmentObject(DisneyDataService())
}
