//
//  DestinationsResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct DestinationsResponse: Codable {
	let destinations: [DestinationEntry]
}

// MARK: - DestinationEntry
struct DestinationEntry: Codable, Identifiable {
	let id, name, slug: String
	let parks: [DestinationParkEntry]
}

// MARK: - DestinationParkEntry
struct DestinationParkEntry: Codable, Identifiable {
	let id, name: String
}


