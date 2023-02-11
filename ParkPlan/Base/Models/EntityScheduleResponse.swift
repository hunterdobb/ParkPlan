//
//  EntityScheduleResponse.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/29/23.
//

import Foundation

// MARK: - Entity Type
enum EntityType: String, Codable, CaseIterable {
    case destination = "DESTINATION"
    case park = "PARK"
    case attraction = "ATTRACTION"
    case restaurant = "RESTAURANT"
    case hotel = "HOTEL"
    case show = "SHOW"
}

// MARK: - Live Status Type
enum LiveStatusType: String, Codable {
    case operating = "OPERATING"
    case down = "DOWN"
    case closed = "CLOSED"
    case refurbishment = "REFURBISHMENT"
}

// MARK: - Return Time State
enum ReturnTimeState: String, Codable {
    case available = "AVAILABLE"
    case tempFull = "TEMP_FULL"
    case finished = "FINISHED"
}

// MARK: - Boarding Group State
enum BoardingGroupState: String, Codable {
    case available = "AVAILABLE"
    case paused = "PAUSED"
    case closed = "CLOSED"
}

// MARK: - Price Data
struct PriceData: Codable {
    let amount: Double? // says 'number' in docs
    let currency: String?
}

// MARK: - Live Queue
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

struct BoardingGroup: Codable {
    let allocationStatus: BoardingGroupState?
    let currentGroupStart: String? //($date-time)
    let currentGroupEnd: String? //($date-time)
    let nextAllocationTime: String? //($date-time)
    let estimatedWait: Int?
}

// MARK: - Live Show Time
struct LiveShowTime: Codable {
    let type: String?
    let startTime: String? //($date-time)
    let endTime: String? //($date-time)
}

// MARK: - Tag Data
struct TagData: Codable {
    let tag: String
    let tagName: String
    let id: String?
    let value: TagValue?
}

enum TagValue: Codable {
    case string(String)
    case number(Double)
    // TODO: I need to figure out how to handle when value is {} type
    case object([String: Any])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            self = .string(string)
            return
        }
        if let number = try? container.decode(Double.self) {
            self = .number(number)
            return
        }
//        if let object = try? container.decode([String: Any].self) {
//            self = .object(object)
//            return
//        }
        throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Failed to decode OneOfType"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .number(let number):
            try container.encode(number)
        case .object(let object):
            print("Tag has object value type: \(object)")
//            try container.encode(object)
        }
    }
}

// MARK: - Entity Data
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

// MARK: - Entity Child
struct EntityChild: Codable, Identifiable {
    let id: String
    let name: String
    let entityType: EntityType
    let slug: String?
    let externalId: String?
}

// MARK: - Entity Children Response
struct EntityChildrenResponse: Codable {
    let id: String
    let name: String
    let entityType: EntityType
    let timezone: String?
    let children: [EntityChild]
}

/*
 "liveData": [
         {
             "id": "2365495a-790b-4a41-831e-65592c8a4359",
             "name": "The Cat in The Hat™",
             "entityType": "ATTRACTION",
             "parkId": "267615cc-8943-4c2a-ae2c-5da728ca591f",
             "externalId": "10833",
             "queue": {
                 "STANDBY": {
                     "waitTime": null
                 }
             },
             "status": "DOWN",
             "lastUpdated": "2023-01-30T14:07:25Z"
         },
 */

// MARK: - Entity Live Data
struct EntityLiveData: Codable, Identifiable {
    let id: String
    let name: String
    let entityType: EntityType
    let parkId: String?
    let externalId: String?
    let queue: LiveQueue?
    let status: LiveStatusType?
    let lastUpdated: Date //($date-time)
    let showTimes: [LiveShowTime]?
}

// MARK: - Entity Live Data Response
struct EntityLiveDataResponse: Codable {
    let id: String?
    let name: String?
    let entityType: EntityType?
    let timezone: String?
    let liveData: [EntityLiveData]?
}

// MARK: - Schedule Entry
struct ScheduleEntry: Codable {
    let date: String //($YYYY-MM-DD)
    let openingTime: String //($date-time)
    let closingTime: String //($date-time)
    let type: ScheduleType

    enum ScheduleType: String, Codable {
        case operating = "OPERATING"
        case ticketedEvent =  "TICKETED_EVENT"
        case privateEvent = "PRIVATE_EVENT"
        case extraHours = "EXTRA_HOURS"
        case info = "INFO"
    }
}

// MARK: - EntityScheduleResponse
struct EntityScheduleResponse: Codable {
    let id: String
    let name: String
    let entityType: EntityType
    let timezone: String
    let schedule: [ScheduleEntry]
}

// MARK: - DestinationParkEntry
struct DestinationParkEntry: Codable, Identifiable {
    let id, name: String
}

// MARK: - DestinationEntry
struct DestinationEntry: Codable, Identifiable {
    let id, name, slug: String
    let parks: [DestinationParkEntry]
}

// MARK: - DestinationsResponse
struct DestinationsResponse: Codable {
    let destinations: [DestinationEntry]
}
