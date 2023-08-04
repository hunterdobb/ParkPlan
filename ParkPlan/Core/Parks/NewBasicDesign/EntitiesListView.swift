//
//  EntitiesListView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import Algorithms
import SwiftUI

struct EntitiesListView: View {
	let park: Park
	var entities: [Entity]

	@EnvironmentObject var disneyDataService: DisneyDataService

	init(park: Park) {
		self.park = park
		entities = Bundle.main.decode(park.entitiesFileName)
		entities.sort { $0.land.rawValue < $1.land.rawValue }
	}

	var parkLandChunks: [[Entity]] {
		entities.chunked { $0.land == $1.land }.map { Array($0) }
	}

	var body: some View {
		List {
			Text(disneyDataService.getOperatingHours(for: park) ?? "Loading Hours")
				.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
				.listRowBackground(Color.clear)

			ForEach(parkLandChunks, id: \.self) { parkLands in
				Section(parkLands.first?.land.rawValue ?? "Unknown") {
					ForEach(parkLands) { entity in
						NavigationLink(destination: EntityDetailView(entity: entity)) {
							VStack(alignment: .leading) {
								Text(entity.name)
								HStack(spacing: 0) {
									Text("\(entity.entityType.rawValue.capitalized)")

									if let standby = disneyDataService.getStandbyWait(for: entity) {
										Text(" • \(standby) min")
									}


								}
								.font(.caption).foregroundStyle(.gray)
							}
						}
					}
				}
			}
		}
		.navigationTitle(park.parkName)
	}
}
