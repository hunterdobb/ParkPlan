//
//  TagData.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/11/23.
//

import Foundation

struct TagData: Decodable {
	let tag: String
	let tagName: String
	let id: String?
	let value: TagValue?
}

enum TagValue: Decodable {
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
