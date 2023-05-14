//
//  Category.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation

struct Category: Decodable {
    struct SubCategory: Decodable {
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

extension Category {
    static var defaultCategory: Category {
        let engineeringSubCategories = [
            Category.SubCategory(subCategory: "Swift", current: "Intermediate", required: "Advanced"),
            Category.SubCategory(subCategory: "Objective-C", current: "Novice", required: "Intermediate")
        ]

        return Category(category: "Engineering", subCategories: engineeringSubCategories)
    }
}
