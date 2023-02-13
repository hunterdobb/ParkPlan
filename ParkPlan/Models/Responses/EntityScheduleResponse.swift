//
//  EntityScheduleResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityScheduleResponse: Codable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String
	let schedule: [ScheduleEntry]
}

// MARK: - Schedule Entry
struct ScheduleEntry: Codable {
	let date: String //($YYYY-MM-DD)
	let openingTime: String //($date-time)
	let closingTime: String //($date-time)
	let type: ScheduleType

	enum ScheduleType: String, Codable {
		case operating = "OPERATING"
		case ticketedEvent =  "TICKETED_EVENT"
		case privateEvent = "PRIVATE_EVENT"
		case extraHours = "EXTRA_HOURS"
		case info = "INFO"
	}
}
