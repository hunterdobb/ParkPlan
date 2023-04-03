//
//  NetworkingManager.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 1/29/23.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()

    private init() {}

	func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
		guard let url = endpoint.url else {
			throw NetworkingError.invalidURL
		}

		let request = buildRequest(from: url, methodType: endpoint.methodType)

		let (data, response) = try await URLSession.shared.data(for: request)

		// Check response
		guard let response = response as? HTTPURLResponse else {
			throw NetworkingError.badResponse
		}

		// Check status code
		guard response.statusCode == 200 else {
			throw NetworkingError.invalidStatusCode(statusCode: response.statusCode)
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		let result = try decoder.decode(T.self, from: data)

		return result
    }
// MUST BE FOR POST? (Removing POST in future)
//	func request(_ endpoint: Endpoint) async throws {
//		guard let url = endpoint.url else {
//			throw NetworkingError.invalidURL
//		}
//
//		let request = buildRequest(from: url, methodType: endpoint.methodType)
//
//		let (_, response) = try await URLSession.shared.data(for: request)
//
//		// Check response
//		guard let response = response as? HTTPURLResponse,
//		(200...300) ~= response.statusCode else {
//			let statusCode = (response as! HTTPURLResponse).statusCode
//			throw NetworkingError.invalidStatusCode(statusCode: statusCode)
//		}
//    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
		case badResponse
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)

		var errorDescription: String? {
			switch self {
			case .badResponse:
				return "The server returned an unrecognized response"
			case .invalidURL:
				return "Invalid URL"
			case .custom(let error):
				return "Something went wrong. \(error.localizedDescription)"
			case .invalidStatusCode(let statusCode):
				return "Error: Status Code (\(statusCode))"
			case .invalidData:
				return "Invalid data"
			case .failedToDecode(let error):
				return "Failed to decode: \(error.localizedDescription)"
			}
		}
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL,
					  methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)

        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }

        return  request
    }
}
