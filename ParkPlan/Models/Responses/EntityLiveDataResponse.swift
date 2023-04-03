//
//  EntityLiveDataResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityLiveDataResponse: Codable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String?
	let liveData: [EntityLiveData]?
}

// MARK: - Entity Live Data
struct EntityLiveData: Codable, Identifiable {
	let id: String
	let name: String
	let entityType: EntityType
	let parkId: String?
	let externalId: String?
	let queue: LiveQueue?
	let status: LiveStatusType?
	let forecast: [Forecast]?
	let lastUpdated: Date //($date-time)
	let showTimes: [LiveShowTime]?
}

// MARK: - Forecast
struct Forecast: Codable, Hashable {
	let time: Date
	let waitTime: Int
	let percentage: Int
}

// MARK: - Live Show Time
struct LiveShowTime: Codable, Hashable {
	let type: String?
	let startTime: Date? //($date-time)
	let endTime: Date? //($date-time)
}

enum LiveStatusType: String, Codable {
	case operating = "OPERATING"
	case down = "DOWN"
	case closed = "CLOSED"
	case refurbishment = "REFURBISHMENT"
}
