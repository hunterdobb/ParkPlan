//
//  DestinationsViewModel.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import OSLog
import SwiftUI

final class DestinationsViewModel: ObservableObject {
    @Published private(set) var destinations = [DestinationEntry]()
    @Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
    @Published var hasError = false
	@Published var searchText = ""

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
	
	/// Returns either all destinations or destinations based on searchText.
	var filteredDestinations: [DestinationEntry] {
		if searchText.isEmpty {
			return destinations
		} else {
			return destinations.filter { $0.parks.contains(where: { $0.name.contains(searchText) }) }
		}
	}
}
