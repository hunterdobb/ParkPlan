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
	let returnStart: Date? //($date-time)
	let returnEnd: Date? //($date-time)
}

struct PaidReturnTime: Codable {
	let state: ReturnTimeState?
	let returnStart: Date? //($date-time)
	let returnEnd: Date? //($date-time)
	let price: PriceData?
}

struct PriceData: Codable {
	let amount: Int? // says 'number' in docs
	let currency: String?
}

struct BoardingGroup: Codable {
	let estimatedWait: Int?
	let allocationStatus: BoardingGroupState?
	let currentGroupStart: Int?
	let currentGroupEnd: Int?
	let nextAllocationTime: Date? //($date-time)
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
