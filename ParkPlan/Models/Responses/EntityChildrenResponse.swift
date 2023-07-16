//
//  EntityChildrenResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityChildrenResponse: Decodable {
	let id: String
	let name: String
	let entityType: EntityType
	let timezone: String?
	let children: [EntityChild]
}

// MARK: - Entity Child
struct EntityChild: Decodable, Identifiable {
	let id: String
	let name: String
	let entityType: EntityType
	let slug: String?
	let externalId: String?
}
