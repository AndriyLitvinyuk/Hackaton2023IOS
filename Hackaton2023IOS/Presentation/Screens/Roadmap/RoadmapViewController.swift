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
        addChart()
        bindViewModel()
    }

    private func addChart() {
        view.addSubview(ganttChartView)
        ganttChartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ganttChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ganttChartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ganttChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ganttChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
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
        contentController.scrollableTimeline = TimeRange(
            from: .current,
            to: .current.adding(weeks: 52)
        )
        contentController.timeScale = .intervals(period: 10, unit: .weeks, origin: .current, rule: .down)
        let controller = GanttChartController(
            headerController: headerController,
            contentController: contentController
        )
        controller.contentController.timeScale = .intervalsWith(period: 1, in: .weeks)
        ganttChartView.controller = controller
    }
}
