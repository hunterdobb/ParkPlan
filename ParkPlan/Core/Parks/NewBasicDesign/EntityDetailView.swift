//
//  EntityDetailView.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import MapKit
import OSLog
import SwiftUI

struct EntityDetailView: View {
	let entity: Entity

	@EnvironmentObject var disneyDataService: DisneyDataService

	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text(entity.name)
					.font(.system(.largeTitle, design: .rounded, weight: .bold))
					.frame(maxWidth: .infinity, alignment: .leading)
				HStack(spacing: 0) {
					Text("\(entity.entityType.rawValue.capitalized) • \(entity.land.rawValue)")
					if let standby = disneyDataService.getStandbyWait(for: entity) {
						Text(" • \(standby) min")
					}
				}
				.foregroundStyle(.gray)
			}
			.padding(.horizontal)

			ScrollView {
				VStack {
					Map(coordinateRegion: .constant(MKCoordinateRegion(
						center: CLLocationCoordinate2D(
							latitude: entity.latitude,
							longitude: entity.longitude),
						span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
					)), annotationItems: [entity]
					) {
						MapMarker(
							coordinate: CLLocationCoordinate2D(
								latitude: $0.latitude,
								longitude: $0.longitude
							),
							tint: .teal
						)
					}
					.aspectRatio(1, contentMode: .fit)
					.clipShape(.rect(cornerRadius: 10, style: .continuous))

					Text(entity.description)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
						.background(.gray.opacity(0.1), in: .rect(cornerRadius: 10, style: .continuous))
					Text(entity.description)
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
						.background(.gray.opacity(0.1), in: .rect(cornerRadius: 10, style: .continuous))
				}
				.padding(.horizontal)
			}
		}
		.navigationTitle(entity.shortName ?? entity.name)
		.navigationBarTitleDisplayMode(.inline)

	}
}

//#Preview {
//	EntityDetailView()
//}
