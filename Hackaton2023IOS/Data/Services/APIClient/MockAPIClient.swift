//
//  MockAPIClient.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//
import Foundation

final class MockAPIClient: APIClient {

    var responseData: Data?
    var error: Error?

    func sendRequest<T: APIRequest>(_ request: T) async throws -> T.Response {
        if let error = error {
            throw error
        }

        guard let responseData = responseData else {
            throw APIError.noData
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.Response.self, from: responseData)
    }
}
