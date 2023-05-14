//
//  APIClient.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//
import Foundation

protocol APIClient {

    func sendRequest<T: APIRequest>(_ request: T) async throws -> T.Response
}

final class URLSessionAPIClient: APIClient {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func sendRequest<T: APIRequest>(_ request: T) async throws -> T.Response {
        do {
            let urlRequest = try request.makeURLRequest()

            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.httpError(httpResponse.statusCode)
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print(String(data: data, encoding: .utf8))
            return try decoder.decode(T.Response.self, from: data)
        } catch {
            throw error
        }
    }
}
