//
//  EntityScheduleResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityScheduleResponse: Decodable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String
	let schedule: [ScheduleEntry]
}

// MARK: - Schedule Entry
struct ScheduleEntry: Decodable {
	let date: String
	let openingTime: String
	let closingTime: String
	let type: ScheduleType

	enum ScheduleType: String, Decodable {
		case operating = "OPERATING"
		case ticketedEvent =  "TICKETED_EVENT"
		case privateEvent = "PRIVATE_EVENT"
		case extraHours = "EXTRA_HOURS"
		case info = "INFO"
	}
}
