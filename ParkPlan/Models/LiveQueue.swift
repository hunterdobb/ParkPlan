//
//  LiveQueue.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct LiveQueue: Decodable {
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

struct Standby: Decodable {
	let waitTime: Int?
}

struct SingleRider: Decodable {
	let waitTime: Int?
}

struct ReturnTime: Decodable {
	let state: ReturnTimeState?
	let returnStart: Date? //($date-time)
	let returnEnd: Date? //($date-time)
}

struct PaidReturnTime: Decodable {
	let state: ReturnTimeState?
	let returnStart: Date? //($date-time)
	let returnEnd: Date? //($date-time)
	let price: PriceData?
}

struct PriceData: Decodable {
	let amount: Int?
	let currency: String?
}

struct BoardingGroup: Decodable {
	let estimatedWait: Int?
	let allocationStatus: BoardingGroupState?
	let currentGroupStart: Int?
	let currentGroupEnd: Int?
	let nextAllocationTime: Date? //($date-time)
}

// MARK: - Enums
enum BoardingGroupState: String, Decodable {
	case available = "AVAILABLE"
	case paused = "PAUSED"
	case closed = "CLOSED"
}

enum ReturnTimeState: String, Decodable {
	case available = "AVAILABLE"
	case tempFull = "TEMP_FULL"
	case finished = "FINISHED"
}
