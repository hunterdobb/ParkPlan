//
//  EntityLiveDataResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityLiveDataResponse: Decodable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String?
	let liveData: [EntityLiveData]?
}

// MARK: - Entity Live Data
struct EntityLiveData: Decodable, Identifiable {
	let id: String
	let name: String
	let entityType: EntityType
	let lastUpdated: Date //($date-time)
	let parkId: String?
	let externalId: String?
	let queue: LiveQueue?
	let status: LiveStatusType?
	let forecast: [Forecast]?
	let showtimes: [LiveShowTime]?
	let operatingHours: [LiveShowTime]?
	let diningAvailability: [DiningAvailability]?

	static let restaurantPreview: EntityLiveData = Bundle.main.decode("Restaurant1LiveData.json")
	static let attractionPreview: EntityLiveData = Bundle.main.decode("Attraction1LiveData.json")
	static let showPreview: EntityLiveData = Bundle.main.decode("Show1LiveData.json")
}

// MARK: - Forecast
struct Forecast: Decodable, Hashable {
	let time: Date
	let waitTime: Int
	let percentage: Int
}

struct DiningAvailability: Decodable, Hashable {
	let partySize: Int
	let waitTime: Int
}

// MARK: - Live Show Time
struct LiveShowTime: Decodable, Hashable {
	let type: String?
	let startTime: Date? //($date-time)
	let endTime: Date? //($date-time)
}

enum LiveStatusType: String, Decodable {
	case operating = "OPERATING"
	case down = "DOWN"
	case closed = "CLOSED"
	case refurbishment = "REFURBISHMENT"
}

enum OperatingHoursType: String {
	case earlyEntry = "Early Entry"
	case operating = "Operating"
}

enum ShowtimeType: String {
	case performanceTime = "Performance Time"
	case operating = "Operating"
}
