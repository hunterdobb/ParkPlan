//
//  ScheduleDataService.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import Foundation

/*
 Disney World Park ids and slugs:
 75ea578a-adc8-4116-a54d-dccb60765ef9	magickingdompark
 47f90d2c-e191-4239-a466-5892ef59a88b	epcot
 288747d1-8b4f-4a64-867e-ea7c9b27bad8	disneyshollywoodstudios
 1c84a229-8862-4648-9c71-378ddd2c7693	disneysanimalkingdomthemepark
 */



@MainActor
class DisneyDataService: ObservableObject {
	@Published var disneyWorld = Bundle.main.decode("ParkData.json", as: Resort.self)

	init() {
		Task {
			await fetchScheduleData()
		}
	}

	func fetchScheduleData() async {
		do {
			async let mkData = try await NetworkingManager.shared.request(
				.schedule(id: "magickingdompark"),
				type: EntityScheduleResponse.self
			)
			async let epData = try await NetworkingManager.shared.request(
				.schedule(id: "epcot"),
				type: EntityScheduleResponse.self
			)
			async let hsData = try await NetworkingManager.shared.request(
				.schedule(id: "disneyshollywoodstudios"),
				type: EntityScheduleResponse.self
			)
			async let akData = try await NetworkingManager.shared.request(
				.schedule(id: "disneysanimalkingdomthemepark"),
				type: EntityScheduleResponse.self
			)

			let (mkIndex, epIndex, hsIndex, akIndex) = (0, 1, 2, 3)
			disneyWorld.parks[mkIndex].schedule = try await mkData.schedule
			disneyWorld.parks[epIndex].schedule = try await epData.schedule
			disneyWorld.parks[hsIndex].schedule = try await hsData.schedule
			disneyWorld.parks[akIndex].schedule = try await akData.schedule
		} catch {
			print(error)
		}

	}

	func getOperatingHours(for entries: [ScheduleEntry]?) -> String? {
		guard let entries else { return nil }

		if let operating = entries.first(where: { $0.type == .operating }) {
			let open = operating.openingTime
			let close = operating.closingTime
			return "\(open.formatted(date: .omitted, time: .shortened)) - \(close.formatted(date: .omitted, time: .shortened))"
		} else {
			return nil
		}
	}
}
