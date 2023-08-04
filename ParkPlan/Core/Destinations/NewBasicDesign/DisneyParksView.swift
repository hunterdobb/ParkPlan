//
//  DestinationsView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import Algorithms
import MapKit
import OSLog
import SwiftUI

/*
struct DisneyParksView: View {
	@EnvironmentObject var data: DisneyDataService

	var body: some View {
		NavigationStack {
			List {
				ForEach(data.disneyWorld.parks) { park in
					NavigationLink {
						EntitiesListView(park: park)
					} label: {
						VStack(alignment: .leading) {
							Text(park.name)
							HStack {
								if let schedule = data.getOperatingHours(for: park.schedule) {
									Text(schedule)
								} else {
									Text("0:00 AM - 0:00 PM")
										.opacity(0)
										.background(
											.secondary.opacity(0.2),
											in: .rect(cornerRadius: 3, style: .continuous)
										)
								}
							}
							.font(.caption)
							.foregroundStyle(.secondary)
						}
					}
				}
			}
			.navigationTitle(data.disneyWorld.name)
		}
	}
}

#Preview {
	DisneyParksView()
		.environmentObject(DisneyDataService())
}
*/
