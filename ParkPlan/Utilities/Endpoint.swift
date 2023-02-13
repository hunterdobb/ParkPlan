//
//  Endpoint.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 2/5/23.
//

import Foundation

enum Endpoint {
	case destinations
	case entity(id: String)
	case children(id: String)
	case live(id: String)
	case schedule(id: String)
	case scheduleDay(id: String, year: String, month: String)
//	case create(submissionData: Data?)
}

// Not used. Only here for example purposes
extension Endpoint {
	enum MethodType {
		case GET
		case POST(data: Data?)
	}
}

extension Endpoint {
	var host: String { "api.themeparks.wiki" }

	var path: String {
		switch self {
		case .destinations:
			return "/v1/destinations"
		case .entity(let id):
			return "/v1/entity/\(id)"
		case .children(let id):
			return "/v1/entity/\(id)/children"
		case .live(let id):
			return "/v1/entity/\(id)/live"
		case .schedule(let id):
			return "/v1/entity/\(id)/schedule"
		case .scheduleDay(let id, let year, let month):
			return "/v1/entity/\(id)/schedule/\(year)/\(month)"
		}
	}

	var methodType: MethodType {
		switch self {
		case .destinations,
				.entity,
				.children,
				.live,
				.schedule,
				.scheduleDay:
			return .GET
		// Any cases that are post would return .POST
//		case .create(let data):
//			return .POST(data: data)
		}
	}
}

extension Endpoint {
	var url: URL? {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = host
		urlComponents.path = path

		return urlComponents.url
	}
}
