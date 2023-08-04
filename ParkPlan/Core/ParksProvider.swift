//
//  ParksProvider.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/23/23.
//

import OSLog
import Foundation

/*

class ParksProvider: ObservableObject {
	@Published private(set) var destinations = [DestinationEntry]()
	@Published private(set) var liveData = [EntityLiveData]()
	@Published private(set) var scheduleData = [ScheduleEntry]()

	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
	@Published var hasError = false

	@MainActor
	func fetchDestinations() async {
		isLoading = true
		defer { isLoading = false } // run this last

		do {
			Logger.network.info("Fetching destinations")
			destinations = try await NetworkingManager.shared.request(
				.destinations,
				type: DestinationsResponse.self
			).destinations
			Logger.network.info("\(self.destinations.count) destinations fetched")
		} catch {
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
	}
}
*/
