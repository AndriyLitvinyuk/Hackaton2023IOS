//
//  Date+Extensions.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 14.05.2023.
//

import Foundation
import GanttisTouch

extension Date {
    func ganttisTime() -> Time {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let hour = calendar.component(.hour, from: self)
        return Time(year: year, month: month, day: day, hour: hour)
    }
}
