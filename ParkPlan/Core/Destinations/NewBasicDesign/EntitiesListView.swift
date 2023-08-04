//
//  EntitiesListView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import SwiftUI

struct EntitiesListView: View {
	let park: Park
	var entities: [Entity]

	@EnvironmentObject var data: DisneyDataService
	@Environment(\.dismiss) var dismiss

	init(park: Park) {
		self.park = park
		entities = Bundle.main.decode(park.entitiesFileName)
		entities.sort { $0.land.rawValue < $1.land.rawValue }
	}

	var landChunks: [[Entity]] {
		entities.chunked { $0.land == $1.land }.map { Array($0) }
	}

	var body: some View {
		List {
			Text(data.getOperatingHours(for: park.schedule) ?? "hours")
			Button("Back") {  }
			ForEach(landChunks, id: \.self) { lands in
				Section(lands.first?.land.rawValue ?? "Unknown") {
					ForEach(lands) { entity in
						NavigationLink(destination: EntityDetailView(entity: entity)) {
							VStack(alignment: .leading) {
								Text(entity.name)
								Text("\(entity.entityType.rawValue.capitalized)")
									.font(.caption).foregroundStyle(.gray)
							}
						}
					}
				}
			}
		}
		.navigationTitle(park.name)
	}
}
