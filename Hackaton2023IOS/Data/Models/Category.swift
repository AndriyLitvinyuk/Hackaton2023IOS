//
//  Category.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation

struct Category: Codable {
    struct SubCategory: Codable {
        let subCategory: String
        let current: String
        let required: String
    }
    let category: String
    let subCategories: [SubCategory]
}

extension Category.SubCategory {
    init(subCategory: String, current: Level, required: Level) {
        self.subCategory = subCategory
        self.current = current.rawValue
        self.required = required.rawValue
    }
}

enum Level: String, RawRepresentable {
    case novice = "Novice"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"
}
