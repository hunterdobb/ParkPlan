//
//  DestinationsViewModel.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import SwiftUI

final class DestinationsViewModel: ObservableObject {
    @Published private(set) var destinations = [DestinationEntry]()
//	@EnvironmentObject var fetcher: DataFetcher
//	@EnvironmentObject var testType: TestType
    @Published private(set) var error: NetworkingManager.NetworkingError?
	@Published private(set) var isLoading = false
    @Published var hasError = false
	@Published var searchText = ""

	@MainActor
    func fetchDestinations() async {
		isLoading = true
		defer { isLoading = false } // run this last

//		await fetcher.fetchDestinations()
//		destinations =  fetcher.allDestinations

		do {
			let response = try await NetworkingManager.shared.request(.destinations, type: DestinationsResponse.self)
			destinations = response.destinations
			print("\(destinations.count)")
		} catch {
			hasError = true
			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
    }

	var searchResults: [DestinationEntry] {
		if searchText.isEmpty {
			return destinations
		} else {
			return destinations.filter { $0.parks.contains(where: { $0.name.contains(searchText) }) }
		}
	}
}
