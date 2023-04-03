//
//  JSONMapperTests.swift
//  ParkPlanTests
//
//  Created by Hunter Dobbelmann on 2/14/23.
//

import Foundation
import XCTest
@testable import ParkPlan

class JSONMapperTests: XCTestCase {
	func test_with_valid_json_successfully_decodes() {
		XCTAssertNoThrow(try StaticJSONMapper.decode(file: "DestinationsStaticData", type: DestinationsResponse.self), "Mapper shouldn't throw an error")

		let destinationResponse = try? StaticJSONMapper.decode(file: "DestinationsStaticData", type: DestinationsResponse.self)
		XCTAssertNotNil(destinationResponse, "Destination response shouldn't be nil")

		XCTAssertEqual(destinationResponse?.destinations.count, 60)
	}

	func test_with_missing_file_error_thrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: DestinationsResponse.self), "An error should be thrown")

		do {
			_ = try StaticJSONMapper.decode(file: "", type: DestinationsResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("Wrong error type for missing files")
				return
			}
			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
		}
	}

	func test_with_invalid_file_error_thrown() {
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "abc", type: DestinationsResponse.self), "An error should be thrown")

		do {
			_ = try StaticJSONMapper.decode(file: "abc", type: DestinationsResponse.self)
		} catch {
			guard let mappingError = error as? StaticJSONMapper.MappingError else {
				XCTFail("Wrong error type for missing files")
				return
			}
			XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
		}
	}

	func test_with_invalid_json_error_thrown() {
		// Using wrong type of EntityChildrenResponse instead of DestinationsResponse to test error thrown
		XCTAssertThrowsError(try StaticJSONMapper.decode(file: "DestinationsStaticData", type: EntityChildrenResponse.self), "An error should be thrown")

		do {
			_ = try StaticJSONMapper.decode(file: "DestinationsStaticData", type: EntityChildrenResponse.self)
		} catch {
			if error is StaticJSONMapper.MappingError {
				XCTFail("Wrong error, expecting a system decoding error")
			}
		}
	}
}
