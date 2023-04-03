//
//  DestinationDataService.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/14/23.
//

import SwiftUI

class DestinationDataService {
	@Published private(set) var allDestinations = [DestinationEntry]()

	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
	@Published var hasError = false

//	init() async {
//		await fetchDestinations()
//	}


	@MainActor
	func fetchDestinations() async {
		isLoading = true
		defer { isLoading = false } // run this last

		do {
			let response = try await NetworkingManager.shared.request(.destinations, type: DestinationsResponse.self)
			allDestinations = response.destinations
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
