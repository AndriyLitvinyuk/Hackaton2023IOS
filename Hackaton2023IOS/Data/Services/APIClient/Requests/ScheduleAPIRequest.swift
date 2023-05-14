//
//  ScheduleAPIRequest.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation

struct ScheduleAPIRequest: APIRequest {
    typealias Response = [ScheduleResponse]

    var path: String = "/default/colleagues/profiles"
    var method: HTTPMethod = .post
    var body: Encodable?

    var headers: [String: String] {
        ["x-api-key": "JiDk2JloBE8aR0xp9JTQyYVonou0JVg9WZYHyMJ5"]
    }
}
