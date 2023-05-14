//
//  RoadmapViewModel.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 14.05.2023.
//

import Foundation
import GanttisTouch
import Combine

final class RoadmapViewModel {
    enum State {
        case loading
        case reloadData([GanttChartItem])
        case error(Error)
    }
    var dataSubject = CurrentValueSubject<State, Never>(.loading)

    private let apiClient = URLSessionAPIClient()

    func sendRequest(date: Date) {
        guard let user = UserInfoSingleton.shared.user else {
            return
        }
        Task {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let body = ScheduleRequestBody(
                desiredDate: dateFormatter.string(from: date), // date,
                categories: user.categories
            )
            let request = ScheduleAPIRequest(body: body)
            do {
                let response = try await apiClient.sendRequest(request)
                setRoadmap(response)
            } catch {
                dataSubject.send(.error(error))
            }
        }
    }

    private func setRoadmap(_ data: [ScheduleResponse]) {
        let subCategories = data.flatMap { category in
            category.subCategories.map { subCategory in
                (subCategory, category.category)
            }
        }
        let categories = data.map { $0.category }
        var categoryColors = [String: GanttisTouch.Color]()
        for index in 0..<categories.count {
            let colors = GanttisTouch.Color.allDefaultColors
            let colorIndex = index < colors.count ? index : colors.count % index
            categoryColors[categories[index]] = GanttisTouch.Color.allDefaultColors[colorIndex]
        }
        var items = [GanttChartItem]()
        for index in 0..<subCategories.count {
            let item = subCategories[index]
            let chartItem = GanttChartItem(
                label: item.0.subCategory,
                row: index,
                start: item.0.start.ganttisTime() ?? Time(Date()),
                finish: item.0.end.ganttisTime() ?? Time(Date())
            )
            chartItem.style.barFillColor = categoryColors[item.1]

            items.append(chartItem)
        }
        dataSubject.send(.reloadData(items))
    }
}

extension String {
    func ganttisTime() -> Time? {
        let parts = self.split(separator: "-")
        guard
            parts.count == 3,
            let year = Int(parts[0]),
            let month = Int(parts[1]),
            let day = Int(parts[2])
        else {
            return nil
        }
        return Time(year: year, month: month, day: day)
    }
}
