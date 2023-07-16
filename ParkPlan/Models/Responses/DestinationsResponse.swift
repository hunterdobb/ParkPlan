//
//  DestinationsResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

/*
 Disney World Park ids and slugs:
 75ea578a-adc8-4116-a54d-dccb60765ef9	magickingdompark
 47f90d2c-e191-4239-a466-5892ef59a88b	epcot
 288747d1-8b4f-4a64-867e-ea7c9b27bad8	disneyshollywoodstudios
 1c84a229-8862-4648-9c71-378ddd2c7693	disneysanimalkingdomthemepark
 */

struct DestinationsResponse: Decodable {
	let destinations: [DestinationEntry]
}

// MARK: - DestinationEntry
struct DestinationEntry: Decodable, Identifiable {
	let id, name, slug: String
	let parks: [DestinationParkEntry]
}

// MARK: - DestinationParkEntry
struct DestinationParkEntry: Decodable, Identifiable {
	let id, name: String
}


