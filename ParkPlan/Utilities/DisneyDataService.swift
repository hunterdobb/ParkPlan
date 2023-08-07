//
//  ScheduleDataService.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/3/23.
//

import Foundation
import OSLog

/*
 Disney World Park ids and slugs:
 75ea578a-adc8-4116-a54d-dccb60765ef9	magickingdompark
 47f90d2c-e191-4239-a466-5892ef59a88b	epcot
 288747d1-8b4f-4a64-867e-ea7c9b27bad8	disneyshollywoodstudios
 1c84a229-8862-4648-9c71-378ddd2c7693	disneysanimalkingdomthemepark
 */

@MainActor
class DisneyDataService: ObservableObject {
	@Published var resort = Bundle.main.decode("ParkData.json", as: Resort.self)

	var parks: [Park] { resort.parks }

	init() {
		Task {
			await fetchScheduleData()
			await fetchLiveData()
		}
	}

	// MARK: - Fetch Data
	func fetchScheduleData() async {
		do {
			async let response = try await NetworkingManager.shared.request(
				.schedule(id: "waltdisneyworldresort"),
				type: EntityScheduleResponse.self
			)
			resort.scheduleData = try await response
		} catch {
			print(error)
		}
	}

	func fetchLiveData() async {
		do {
			async let response = try await NetworkingManager.shared.request(
				.live(id: "waltdisneyworldresort"),
				type: EntityLiveDataResponse.self
			)

			resort.liveData = try await response.liveData
		} catch {
			print(error)
		}
	}

	// MARK: - Get Data
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

	/// Returns String representing the operating hours for current day.
	/// Returns nil if operating hours are unavailable.
	///
	/// Ex: 9:00 AM - 10:00 PM
	func getOperatingHours(for park: Park) -> String? {
		guard let entries = resort.parksSchedule?.first(where: { $0.id == park.id })?.schedule else {
			return nil
		}

		if let operating = entries.first(where: { $0.type == .operating }) {
			let open = operating.openingTime
			let close = operating.closingTime
			return "\(open.formatted(date: .omitted, time: .shortened)) - \(close.formatted(date: .omitted, time: .shortened))"
		} else {
			return nil
		}
	}

	private func getLiveData(for entity: Entity) -> EntityLiveData? {
		if let liveData = resort.liveData,
		   let entityLiveData = liveData.first(where: { entity.id == $0.id }) {
			return entityLiveData
		} else {
			return nil
		}
	}

	func getStandbyValue(for entity: Entity) -> Int? {
		guard let entityLiveData = getLiveData(for: entity) else { return nil }
		return entityLiveData.queue?.standby?.waitTime
	}

	func getStandbyString(for entity: Entity) -> String? {
		guard let entityLiveData = getLiveData(for: entity) else { return nil }
		guard let standby = entityLiveData.queue?.standby?.waitTime else { return nil }
		return "\(standby) min"
	}

	func getUpdateTime(for entity: Entity) -> Date? {
		guard let entityLiveData = getLiveData(for: entity) else { return nil }
		return entityLiveData.lastUpdated
	}
}
