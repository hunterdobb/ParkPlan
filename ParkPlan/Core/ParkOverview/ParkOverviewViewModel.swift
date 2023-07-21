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
	@Published private(set) var children = [EntityChild]() // needed?
	@Published private(set) var liveData: [EntityLiveData]?
	@Published private(set) var scheduleData: [ScheduleEntry]?

	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false
	@Published var isLoading = false

	@Published var selection: EntityType = .attraction

	init(park: DestinationParkEntry) {
		self.park = park
	}

	// MARK: - Attractions Computed Properties
	var allAttractions: [EntityChild] {
		children.filter { $0.entityType == .attraction }
	}

	var operatingHours: String? {
		if let scheduleData = scheduleData,
		   let operating = scheduleData.first(where: { $0.type == .operating }) {
			let open = operating.openingTime
			let close = operating.closingTime
			return "\(open.formatted(date: .omitted, time: .shortened)) - \(close.formatted(date: .omitted, time: .shortened))"
		} else {
			return nil
		}
	}

	var updatedAttractions: [EntityChild] {
		var array = [EntityChild]()
		for attraction in allAttractions {
			if dataIsUpdated(for: attraction)
			&& getLiveData(childId: attraction.id, liveData: liveData) != nil {
				array.append(attraction)
			}
		}
		return array
	}

	var operatingAttractions: [EntityChild] {
		var array = [EntityChild]()
		for attraction in allAttractions {
			if dataIsUpdated(for: attraction)
				&& getLiveData(childId: attraction.id, liveData: liveData) != nil
				&& getLiveData(childId: attraction.id, liveData: liveData)?.status == .operating {
				array.append(attraction)
			}
		}

		return array
	}

	var attractionsWithNoLiveData: [EntityChild] {
		var array = [EntityChild]()
		for attraction in allAttractions {
			if dataIsUpdated(for: attraction) && getLiveData(childId: attraction.id, liveData: liveData) == nil {
				array.append(attraction)
			}
		}
		return array
	}

	// MARK: - Restaurants Computed Properties
	var restaurants: [EntityChild] {
		children.filter { $0.entityType == .restaurant }
	}

	// MARK: - 'Shows' Computed Properties
	var shows: [EntityChild] {
		children.filter { $0.entityType == .show }
	}

	var operatingShows: [EntityChild] {
		var array = [EntityChild]()
		for child in children {
			if child.entityType == .show,
			   getLiveData(childId: child.id, liveData: liveData)?.status == .operating {
				array.append(child)
			}
		}
		return array
	}

	// Used to ensure the picker only shows attractions, shows, and restaurants
	func hasType(_ type: EntityType) -> Bool {
		return (type != .park) && (type != .destination) && (type != .hotel)
	}

	@MainActor
	func fetchData() async {
		await fetchLiveData()
		await fetchScheduleData()
		await fetchChildren()
	}

	@MainActor
	func fetchScheduleData() async {
		isLoading = true
		defer { isLoading = false }

		do {
			Logger.network.info("Fetching schedule data for id: \(self.park.id)")
			let response = try await NetworkingManager.shared.request(.schedule(id: self.park.id), type: EntityScheduleResponse.self)
			scheduleData = response.schedule
		} catch {
			hasError = true

			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}

	@MainActor
	func fetchChildren() async {
		isLoading = true
		defer { isLoading = false }

		do {
			Logger.network.info("Fetching live data for id: \(self.park.id)")
			let response = try await NetworkingManager.shared.request(.children(id: self.park.id), type: EntityChildrenResponse.self)
			children = response.children
		} catch {
			hasError = true

			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}

	@MainActor
	func fetchLiveData() async {
		isLoading = true
		defer { isLoading = false }

		do {
			Logger.network.info("Fetching live data for id: \(self.park.id)")
			let response = try await NetworkingManager.shared.request(.live(id: self.park.id), type: EntityLiveDataResponse.self)
			liveData = response.liveData
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

	func getLiveData(childId: String, liveData: [EntityLiveData]?) -> EntityLiveData? {
		if let liveData {
			return liveData.first(where: { $0.id == childId })
		}

		return nil
	}

	func standbyWaitText(for child: EntityChild) -> String {
		if let liveData = getLiveData(childId: child.id, liveData: liveData) {
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

	func dateLastUpdated(id: String) -> Date? {
		if let liveData = getLiveData(childId: id, liveData: liveData) {
			return liveData.lastUpdated
		}

		return nil
	}

	// Return true if the liveData has been updated within this month
	func dataIsUpdated(for child: EntityChild) -> Bool {
		// This is for busch gardens
		// TODO: Remove this near halloween
		if child.name.contains("Howl-O-Scream") {
			return false
		}

		if let liveData = getLiveData(childId: child.id, liveData: liveData) {
			return Calendar.current.isDate(.now, equalTo: liveData.lastUpdated, toGranularity: .month)
		}

		return true
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
