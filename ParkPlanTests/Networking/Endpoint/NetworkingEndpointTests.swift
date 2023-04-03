//
//  NetworkingEndpointTests.swift
//  ParkPlanTests
//
//  Created by Hunter Dobbelmann on 2/14/23.
//

import XCTest
@testable import ParkPlan

final class NetworkingEndpointTests: XCTestCase {
	/*
	 case destinations
	 case entity(id: String)
	 case children(id: String)
	 case live(id: String)
	 case schedule(id: String)
	 case scheduleDay(id: String, year: String, month: String)
	 */

	func test_with_destinations_endpoint_request_is_valid() {
		let endpoint = Endpoint.destinations
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/destinations", "The path should be /v1/destinations")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/destinations", "The generated url doesn't match our endpoint")
	}

	func test_with_entity_endpoint_request_is_valid() {
		let destinationId = "waltdisneyworldresort"
		let endpoint = Endpoint.entity(id: destinationId)
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/entity/\(destinationId)", "The path should be /v1/entity/\(destinationId)")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/entity/\(destinationId)", "The generated url doesn't match our endpoint")
	}

	func test_with_children_endpoint_request_is_valid() {
		let destinationId = "waltdisneyworldresort"
		let endpoint = Endpoint.children(id: destinationId)
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/entity/\(destinationId)/children", "The path should be /v1/entity/\(destinationId)/children")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/entity/\(destinationId)/children", "The generated url doesn't match our endpoint")
	}

	func test_with_live_endpoint_request_is_valid() {
		let destinationId = "waltdisneyworldresort"
		let endpoint = Endpoint.live(id: destinationId)
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/entity/\(destinationId)/live", "The path should be /v1/entity/\(destinationId)/live")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/entity/\(destinationId)/live", "The generated url doesn't match our endpoint")
	}

	func test_with_schedule_endpoint_request_is_valid() {
		let destinationId = "waltdisneyworldresort"
		let endpoint = Endpoint.schedule(id: destinationId)
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/entity/\(destinationId)/schedule", "The path should be /v1/entity/\(destinationId)/schedule")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/entity/\(destinationId)/schedule", "The generated url doesn't match our endpoint")
	}

	func test_with_scheduleDay_endpoint_request_is_valid() {
		let destinationId = "waltdisneyworldresort"
		let year = "2023"
		let month = "02"
		let endpoint = Endpoint.scheduleDay(id: destinationId, year: year, month: month)
		XCTAssertEqual(endpoint.host, "api.themeparks.wiki", "The host should be api.themeparks.wiki")
		XCTAssertEqual(endpoint.path, "/v1/entity/\(destinationId)/schedule/\(year)/\(month)", "The path should be /v1/entity/\(destinationId)/schedule/\(year)/\(month)")
		XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

		XCTAssertEqual(endpoint.url?.absoluteString, "https://api.themeparks.wiki/v1/entity/\(destinationId)/schedule/\(year)/\(month)", "The generated url doesn't match our endpoint")
	}

}
