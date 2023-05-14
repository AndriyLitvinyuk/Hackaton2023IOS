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
        // swiftlint: disable all
        let categories = [
            Category(category: "Managerial", subCategories: [
                Category.SubCategory(subCategory: "Prototyping", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Requirements Definition and Management", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Product Ownership", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Kanban", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Interviews", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Backlog management", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Use Cases and Scenarios", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Stakeholder List, Map, or Personas", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Stakeholder Management", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Brainstorming", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Estimation", current: .novice, required: .intermediate)
            ]),
            Category(category: "Practices", subCategories: [
                Category.SubCategory(subCategory: "AT/Agile", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Requirements approval and prioritization awareness", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "UI Prototyping", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "BA Stakeholders management", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Engineering Maturity", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Vision", current: .novice, required: .intermediate)
            ]),
            Category(category: "Leadership & Soft Skills", subCategories: [
                Category.SubCategory(subCategory: "Mentoring", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Roadmap", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Financial Awareness", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Problem-solving", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Client Relationship Management", current: .novice, required: .intermediate),
                Category.SubCategory(subCategory: "Delivery Excellence", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Developing Others", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Meeting Facilitation", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Ownership", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Teamwork and Collaboration", current: .intermediate, required: .advanced),
                Category.SubCategory(subCategory: "Market orientation", current: .advanced, required: .expert)
            ]),
            Category(category: "Technologies", subCategories: [
                Category.SubCategory(subCategory: "Confluence", current: .novice, required: .intermediate),
            ]),
            Category(category: "Academic Disciplines", subCategories: [
                Category.SubCategory(subCategory: "English", current: .advanced, required: .expert),
            ]),
        ]
        // swiftlint: enable all
        return User(
            firstName: "Victor",
            lastName: "Goban",
            title: "Product Manager I",
            desiredTitle: "Product Manager II",
            categories: categories
        )
    }
}
