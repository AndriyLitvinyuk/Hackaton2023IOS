//
//  ScheduleRequestBody.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation

struct ScheduleRequestBody: Encodable {
    let desiredDate: Date
    let categories: [Category]
}
