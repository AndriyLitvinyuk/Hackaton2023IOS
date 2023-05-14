//
//  RoadmapData.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 14.05.2023.
//

import Foundation

typealias RoadmapData = [Category]

struct Category: Decodable {
    let category: String
    let subCategories: [Subcategory]
}
struct Subcategory: Decodable {
    let subCategory: String
    let start: Date
    let end: Date
    let link: String
}

extension RoadmapData {
    static func mock() -> RoadmapData {
        [
            Category(
                category: "Engineering",
                subCategories: [
                    Subcategory(
                        subCategory: "IOS",
                        start: Date(),
                        end: Date.inNumberPfDays(7),
                        link: "aaaaaaaa"
                    ),
                    Subcategory(
                        subCategory: "REST",
                        start: Date.inNumberPfDays(7),
                        end: Date.inNumberPfDays(15),
                        link: "aaaaaaaa"
                    ),
                    Subcategory(
                        subCategory: "SwiftUI",
                        start: Date.inNumberPfDays(10),
                        end: Date.inNumberPfDays(22),
                        link: "aaaaaaaa"
                    )
                ]
            ),
            Category(
                category: "Management",
                subCategories: [
                    Subcategory(
                        subCategory: "Leadership",
                        start: Date.inNumberPfDays(3),
                        end: Date.inNumberPfDays(17),
                        link: "aaaaaaaa"
                    ),
                    Subcategory(
                        subCategory: "Scram",
                        start: Date.inNumberPfDays(17),
                        end: Date.inNumberPfDays(28),
                        link: "aaaaaaaa"
                    )
                ]
            )
        ]
    }
}

extension Date {
    static func inNumberPfDays(_ number: Int) -> Date {
        let day = TimeInterval(86400)
        return Date(timeIntervalSinceNow: TimeInterval(number) * day)
    }
}
