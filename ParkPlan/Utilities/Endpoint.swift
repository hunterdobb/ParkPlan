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

	var host: String { "api.themeparks.wiki" }

	var url: URL? {
		var urlComponents = URLComponents()

		urlComponents.scheme = "https"
		urlComponents.host = host
		urlComponents.path = path

		return urlComponents.url
	}
}
