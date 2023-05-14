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
    let subcategories: [Subcategory]
}
struct Subcategory: Decodable {
    let subCategory: String
    let start: String
    let end: String
    let link: String
}
