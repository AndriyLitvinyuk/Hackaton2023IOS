//
//  ScheduleResponse.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation

struct ScheduleResponse: Decodable {
    struct Subcategory: Decodable {
        let subCategory: String
        let start: String
        let end: String
        let link: String?
    }
    let category: String
    let subCategories: [Subcategory]
}
