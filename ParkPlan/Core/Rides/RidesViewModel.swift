//
//  RidesViewModel.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/30/23.
//

import Foundation

final class RidesViewModel: ObservableObject {

    @Published private(set) var rides: [EntityLiveData]?
    @Published var selection: EntityType = .attraction
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
	@Published var isLoading = false

	@MainActor
    func fetchRides(for id: String) async {
		isLoading = true
		defer { isLoading = false }

		do {
			let response = try await NetworkingManager.shared.request(.live(id: id), type: EntityLiveDataResponse.self)
			rides = response.liveData
		} catch {
			hasError = true

			if let networkingError = error as? NetworkingManager.NetworkingError {
				self.error = networkingError
			} else {
				self.error = .custom(error: error)
			}
		}
    }

    func hasType(_ type: EntityType) -> Bool {
        return (type != .park) && (type != .destination) && (type != .hotel)
    }
}

// MARK: - OLD
/*
 NetworkingManager.shared.request(.live(id: id), type: EntityLiveDataResponse.self) { [weak self] res in
	 guard let self else { return }

	 DispatchQueue.main.async {
		 switch res {
		 case .success(let response):
			 if let liveData = response.liveData {
				 self.rides = liveData.sorted(by: { ride1, ride2 in
					 if let ride1Wait = ride1.queue?.standby?.waitTime,
						let ride2Wait = ride2.queue?.standby?.waitTime {
						 return ride1Wait < ride2Wait
					 } else {
						 return ride1.name < ride2.name
					 }
				 })
			 }
		 case .failure(let error):
			 self.hasError = true
			 self.error = error as? NetworkingManager.NetworkingError
		 }
	 }
 }
 */
