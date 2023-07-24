//
//  ParkOverviewViewModel.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/13/23.
//

import OSLog
import SwiftUI

final class ParkOverviewViewModel: ObservableObject {
	@Published var park: DestinationParkEntry
	@Published private(set) var liveData = [EntityLiveData]()
	@Published private(set) var scheduleData = [ScheduleEntry]()

	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false
	@Published var isLoading = false

	@Published var selection: EntityType = .attraction

	init(park: DestinationParkEntry) {
		self.park = park
	}

	var allAttractions: [EntityLiveData] {
		liveData.filter { $0.entityType == .attraction }
	}

	var operatingHours: String? {
		if let operating = scheduleData.first(where: { $0.type == .operating }) {
			let open = operating.openingTime
			let close = operating.closingTime
			return "\(open.formatted(date: .omitted, time: .shortened)) - \(close.formatted(date: .omitted, time: .shortened))"
		} else {
			return nil
		}
	}

	var updatedAttractions: [EntityLiveData] {
		allAttractions.filter { dataIsUpdated(for: $0) }
	}

	var operatingAttractions: [EntityLiveData] {
		allAttractions.filter { (dataIsUpdated(for: $0)) && ($0.status == .operating) }
	}

	var restaurants: [EntityLiveData] {
		liveData.filter { $0.entityType == .restaurant }
	}

	var shows: [EntityLiveData] {
		liveData.filter { $0.entityType == .show }
	}

	var operatingShows: [EntityLiveData] {
		liveData.filter { ($0.entityType == .show) && ($0.status == .operating) }
	}

	@MainActor
	func fetchData() async {
		await fetchLiveData()
		await fetchScheduleData()
	}

	@MainActor
	func fetchLiveData() async {
		isLoading = true
		defer { isLoading = false }

		do {
			Logger.network.info("Fetching live data for id: \(self.park.id)")
			let response = try await NetworkingManager.shared.request(.live(id: self.park.id), type: EntityLiveDataResponse.self)
			liveData = response.liveData
			Logger.network.info("Fetched \(response.liveData.count) live data entries")
		} catch {
			print(error)
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}

	@MainActor
	func fetchScheduleData() async {
		isLoading = true
		defer { isLoading = false }

		do {
			Logger.network.info("Fetching schedule data for id: \(self.park.id)")
			let response = try await NetworkingManager.shared.request(.schedule(id: self.park.id), type: EntityScheduleResponse.self)
			scheduleData = response.schedule
			Logger.network.info("Fetched \(response.schedule.count) schedule data entries")
		} catch {
			hasError = true

			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}

	func getLiveData(id: String) -> EntityLiveData? {
		liveData.first(where: { $0.id == id })
	}

	func standbyWaitText(id: String) -> String {
		if let liveData = getLiveData(id: id) {
			let wait = liveData.queue?.standby?.waitTime
			if liveData.status == .operating {
				if let wait {
					return "\(wait)m"
				} else {
					return "Open"
				}
			} else {
				return liveData.status?.rawValue.capitalized ?? "Unknown"
			}
		}

		return "N/A"
	}

	// Return true if the liveData has been updated within this month
	func dataIsUpdated(for data: EntityLiveData) -> Bool {
		Calendar.current.isDate(.now, equalTo: data.lastUpdated, toGranularity: .month)
	}

	func getColorForLiveData(text: String) -> Color {
		// Drop the m, so 30m becomes 30
		if let wait = Int(text.dropLast(1)) {
			if wait > 60 {
				return .red
			} else if wait > 30 {
				return .orange
			} else {
				return .green
			}
		} else {
			if text == "Down" || text == "Closed" || text == "Refurbishment" {
				return .pink
			} else {
				return .teal
			}
		}
	}
}
