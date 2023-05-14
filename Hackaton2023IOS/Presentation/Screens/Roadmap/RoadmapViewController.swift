//
//  RoadmapViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import GanttisTouch

final class RoadmapViewController: UIViewController, StoryboardInstantiable {

    private var ganttChartView = GanttChart()
    var viewModel: RoadmapViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = RoadmapData.mock()
        let subCategories = data.flatMap { $0.subCategories }
        var items = [GanttChartItem]()
        for index in 0..<subCategories.count {
            let item = subCategories[index]

            items.append(
                GanttChartItem(
                    label: item.subCategory,
                    row: index,
                    start: item.start.ganttisTime(),
                    finish: item.end.ganttisTime()
                )
            )
        }
        view.addSubview(ganttChartView)
        let headerController = GanttChartHeaderController()
        let contentController = GanttChartContentController(items: items)
        contentController.desiredScrollableRowCount = 10
        contentController.scrollableTimeline = TimeRange(
            from: items[0].start,
            to: items[items.count - 2].finish.adding(weeks: 2)
        )
        let controller = GanttChartController(
            headerController: headerController,
            contentController: contentController
        )
        ganttChartView.controller = controller
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ganttChartView.frame = view.bounds
    }

    private func reloadChart(_ data: ) {
        
    }
}
