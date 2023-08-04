//
//  EntityType.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

enum EntityType: String, Decodable, CaseIterable, Hashable {
	case destination = "DESTINATION"
	case park = "PARK"
	case attraction = "ATTRACTION"
	case restaurant = "RESTAURANT"
	case hotel = "HOTEL"
	case show = "SHOW"
}


