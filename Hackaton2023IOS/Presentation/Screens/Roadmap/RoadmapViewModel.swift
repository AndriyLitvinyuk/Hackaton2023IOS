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
    }
    var dataSubject = CurrentValueSubject<State, Never>(.loading)

    private let apiClient = URLSessionAPIClient()

    func sendRequest(date: Date) {
        guard
            let user = UserInfoSingleton.shared.user,
            let date = Calendar.current.date(byAdding: .year, value: 1, to: Date()) else {
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
                let scheduleResponse = response as [ScheduleResponse]
                setRoadmap(response)
            } catch {
//                fatalError()
            }
        }
    }

    private func setRoadmap(_ data: [ScheduleResponse]) {
        let subCategories = data.flatMap { $0.subCategories }
        var items = [GanttChartItem]()
        for index in 0..<subCategories.count {
            let item = subCategories[index]

            items.append(
                GanttChartItem(
                    label: item.subCategory,
                    row: index,
                    start: item.start.ganttisTime() ?? Time(Date()),
                    finish: item.end.ganttisTime() ?? Time(Date())
                )
            )
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
