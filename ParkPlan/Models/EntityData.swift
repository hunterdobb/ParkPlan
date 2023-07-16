//
//  EntityData.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct EntityData: Decodable {
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

	struct Location: Decodable {
	  let latitude: Double
	  let longitude: Double
	}
}
