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

	func request<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
		guard let url = endpoint.url else {
			throw NetworkingError.invalidURL
		}

		let request = URLRequest(url: url)

		let (data, response) = try await URLSession.shared.data(for: request)

		guard let response = response as? HTTPURLResponse else {
			throw NetworkingError.badResponse
		}

		guard response.statusCode == 200 else {
			throw NetworkingError.invalidStatusCode(statusCode: response.statusCode)
		}

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		return try decoder.decode(T.self, from: data)
    }
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
