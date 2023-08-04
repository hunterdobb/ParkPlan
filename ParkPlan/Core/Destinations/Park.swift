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
}

struct Park: Decodable, Identifiable {
	let id: String
	let name: String
	let location: Location
	let entitiesFileName: String
	let bannerImageName: String

	var schedule: [ScheduleEntry]?
}

enum ParkNames: String {
	case magicKingdom = "Magic Kingdom"
	case epcot = "EPCOT"
	case hollywoodStudios = "Hollywood Studios"
	case animalKingdom = "Animal Kingdom"
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
//	let liveData: EntityLiveData?

	static var magicKingdomEntities: [Entity] = Bundle.main.decode("MagicKingdomData.json")
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
