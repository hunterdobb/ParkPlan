//
//  LiveQueue.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct LiveQueue: Codable {
	let standby: Standby?
	let singleRider: SingleRider?
	let returnTime: ReturnTime?
	let paidReturnTime: PaidReturnTime?
	let boardingGroup: BoardingGroup?

	enum CodingKeys: String, CodingKey {
		case standby = "STANDBY"
		case singleRider = "SINGLE_RIDER"
		case returnTime = "RETURN_TIME"
		case paidReturnTime = "PAID_RETURN_TIME"
		case boardingGroup = "BOARDING_GROUP"
	}
}

struct Standby: Codable {
	let waitTime: Int?
}

struct SingleRider: Codable {
	let waitTime: Int?
}

struct ReturnTime: Codable {
	let state: ReturnTimeState?
	let returnStart: String? //($date-time)
	let returnEnd: String? //($date-time)
}

struct PaidReturnTime: Codable {
	let state: ReturnTimeState?
	let returnStart: String? //($date-time)
	let returnEnd: String? //($date-time)
	let price: PriceData?
}

struct PriceData: Codable {
	let amount: Double? // says 'number' in docs
	let currency: String?
}

struct BoardingGroup: Codable {
	let allocationStatus: BoardingGroupState?
	let currentGroupStart: String? //($date-time)
	let currentGroupEnd: String? //($date-time)
	let nextAllocationTime: String? //($date-time)
	let estimatedWait: Int?
}

// MARK: - Enums
enum BoardingGroupState: String, Codable {
	case available = "AVAILABLE"
	case paused = "PAUSED"
	case closed = "CLOSED"
}

enum ReturnTimeState: String, Codable {
	case available = "AVAILABLE"
	case tempFull = "TEMP_FULL"
	case finished = "FINISHED"
}
