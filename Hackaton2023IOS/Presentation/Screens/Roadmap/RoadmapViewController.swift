//
//  RoadmapViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import GanttisTouch
import Combine

final class RoadmapViewController: UIViewController, StoryboardInstantiable {

    private var cancellables = Set<AnyCancellable>()
    private var ganttChartView = GanttChart()
    var viewModel: RoadmapViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ganttChartView)
        bindViewModel()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ganttChartView.frame = view.bounds
    }

    private func bindViewModel() {
        viewModel?.dataSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    return

                case let .reloadData(items):
                    self?.reloadChart(items)
                }
            }.store(in: &cancellables)
    }

    private func reloadChart(_ items: [GanttChartItem]) {
        let headerController = GanttChartHeaderController()
        let contentController = GanttChartContentController(items: items)
        contentController.desiredScrollableRowCount = 10
        contentController.scrollableTimeline = TimeRange(
            from: Time(year: 2023, month: 05, day: 14), // items[0].start,
            to: Time(year: 2025, month: 05, day: 14) // items[items.count - 1].finish.adding(weeks: 1)
        )
        let controller = GanttChartController(
            headerController: headerController,
            contentController: contentController
        )
        controller.contentController.timeScale = .intervalsWith(period: 1, in: .weeks)
        ganttChartView.controller = controller
    }
}
