//
//  EntityData.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityData: Codable {
	let id: String
	let name: String
	let slug: String
	let location: Location?
	let parentId: String?
	let timezone: String
	let entityType: EntityType
	let destinationId: String?
	let externalId: String
	let tags: TagData?

	struct Location: Codable {
	  let latitude: Double
	  let longitude: Double
	}
}
