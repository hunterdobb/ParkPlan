//
//  Park.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 8/1/23.
//

import Foundation

struct Resort: Decodable, Identifiable {
	let id: String
	let name: String
	let slug: String
	var parks: [Park]
	
	var liveData: [EntityLiveData]?
	var scheduleData: EntityScheduleResponse?

	var parksSchedule: [EntityScheduleResponse]? {
		scheduleData?.parks
	}
}

struct Park: Decodable, Identifiable, Hashable {
	static func == (lhs: Park, rhs: Park) -> Bool {
		lhs.id == rhs.id
	}
	
	let id: String
	let name: ParkNames
	let location: Location
	let entitiesFileName: String
	let bannerImageName: String

	var parkName: String { name.rawValue }

//	static func == (lhs: Park, rhs: Park) -> Bool {
//		lhs.id == rhs.id
//	}
//
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

enum ParkNames: String, Decodable {
	case magicKingdom 		= "Magic Kingdom"
	case epcot 				= "EPCOT"
	case hollywoodStudios 	= "Hollywood Studios"
	case animalKingdom 		= "Animal Kingdom"
}

struct Entity: Decodable, Identifiable, Hashable {
	let id: String
	let name: String
	let shortName: String?
	let land: LandType
	let entityType: EntityType
	let slug: String?
	let externalId: String
	let latitude: Double
	let longitude: Double
	let description: String

	static var example = Entity(
		id: "e516f303-e82d-4fd3-8fbf-8e6ab624cf89",
		name: "Rock 'n' Roller Coaster Starring Aerosmith",
		shortName: "Rock 'n' Roller Coaster",
		land: LandType.sunsetBoulevard,
		entityType: EntityType.attraction,
		slug: "rocknrollercoasterstarringaerosmith",
		externalId: "80010182;entityType=Attraction",
		latitude: 28.359712,
		longitude: -81.56059,
		description: "Buckle up for an adrenaline-pumping rock 'n' roll journey with Aerosmith. This high-speed indoor coaster launches you into the music world, featuring loops, corkscrews, and a rocking soundtrack. Feel the rush as you ride through the neon-lit Hollywood backdrop, making this attraction a must-do for thrill-seekers and music enthusiasts alike."
	)

//	static var magicKingdomEntities: [Entity] = Bundle.main.decode("MagicKingdomData.json")

//	static func == (lhs: Entity, rhs: Entity) -> Bool {
//		lhs.id == rhs.id
//	}
//
//	func hash(into hasher: inout Hasher) {
//		hasher.combine(id)
//	}
}

enum LandType: String, Decodable, CaseIterable {
	// MARK: - Magic Kingdom
	case adventureland 	= "Adventureland"
	case fantasyland 	= "Fantasyland"
	case frontierland 	= "Frontierland"
	case libertySquare	= "Liberty Square"
	case mainStreetUSA 	= "Main Street, U.S.A."
	case tomorrowland 	= "Tomorrowland"
	static var allMagicKingdom: [LandType] = [
		.adventureland, .fantasyland, .frontierland, .libertySquare, .mainStreetUSA, .tomorrowland
	]

	// MARK: - EPCOT
	case worldCelebration 	= "World Celebration"
	case worldDiscovery 	= "World Discovery"
	case worldNature 		= "World Nature"
	case worldShowcase 		= "World Showcase"
	static var allEpcot: [LandType] = [
		.worldCelebration, .worldDiscovery, .worldNature, .worldShowcase
	]

	// MARK: - Hollywood Studios
	case animationCourtyard 	= "Animation Courtyard"
	case commissaryLane 		= "Commissary Lane"
	case echoLake 				= "Echo Lake"
	case grandAvenue 			= "Grand Avenue"
	case hollywoodBoulevard 	= "Hollywood Boulevard"
	case mickeyAvenue 			= "Mickey Avenue"
	case muppetsCourtyard 		= "Muppets Courtyard"
	case pixarPlace 			= "Pixar Place"
	case starWarsGalaxysEdge 	= "Star Wars: Galaxy's Edge"
	case sunsetBoulevard 		= "Sunset Boulevard"
	case toyStoryLand 			= "Toy Story Land"
	static var allHollywoodStudios: [LandType] = [
		.animationCourtyard, .commissaryLane, .echoLake, .grandAvenue, .hollywoodBoulevard, .mickeyAvenue,
		.muppetsCourtyard, .pixarPlace, .starWarsGalaxysEdge, .sunsetBoulevard, .toyStoryLand
	]

	// MARK: - Animal Kingdom
	case africa	 					= "Africa"
	case asia						= "Asia"
	case dinoLandUSA 				= "DinoLand U.S.A."
	case discoveryIsland 			= "Discovery Island"
	case na 						= "NA"
	case oasis 						= "Oasis"
	case pandoraTheWorldOfAvatar	= "Pandora: The World of Avatar"
	case rafikisPlanetWatch 		= "Rafiki's Planet Watch"
	static var allAnimalKingdom: [LandType] = [
		.africa, .asia, .dinoLandUSA, .discoveryIsland, .na, .oasis, .pandoraTheWorldOfAvatar, .rafikisPlanetWatch
	]
}
