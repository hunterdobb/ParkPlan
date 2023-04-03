//
//  DataFetcher.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/18/23.
//

import SwiftUI

class DataFetcher: ObservableObject {
	@Published private(set) var allDestinations = [DestinationEntry]()

	// Data for views
	@Published private(set) var error: NetworkingManager.NetworkingError?
	@Published var hasError = false

	//	@Published private(set) var isLoading = false

	@MainActor
	func fetchDestinations() async {
		// We'll handle this in the VMs
//		isLoading = true
//		defer { isLoading = false } <-- run this last

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
