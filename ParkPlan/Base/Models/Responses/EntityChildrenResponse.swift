//
//  EntityChildrenResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityChildrenResponse: Codable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String?
	let children: [EntityChild]
}

// MARK: - Entity Child
struct EntityChild: Codable, Identifiable {
	let id: String
	let name: String
	let entityType: EntityType
	let slug: String?
	let externalId: String?
}
