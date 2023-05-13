//
//  APIRequest.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case noData
}

protocol APIRequest {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }

    func makeURLRequest() throws -> URLRequest
}

extension APIRequest {
    
    var baseURL: URL? {
        return URL(string: "https://example.com")
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
}
