//
//  User.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct User: Decodable {
    let firstName: String
    let lastName: String
    let title: String
    let desiredTitle: String
    let categories: [Category]
}

extension User {
    static var defaultUser: User {
        return User(
            firstName: "Victor",
            lastName: "Goban",
            title: "Project Manager",
            desiredTitle: "Product Manager",
            categories: Array(repeating: Category.defaultCategory, count: 5)
        )
    }
}
