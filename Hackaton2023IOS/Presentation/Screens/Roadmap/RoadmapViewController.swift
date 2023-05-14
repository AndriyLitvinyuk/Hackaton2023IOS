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
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate your schedule", for: .normal)
        button.setTitleColor(
            .primaryColor,
            for: .normal
        )
        var configuration = UIButton.Configuration.bordered()
        configuration.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
        button.configuration = configuration
        button.layer.borderColor = UIColor.primaryColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateChartButtonPressed), for: .touchDown)
        return button
    }()
    var viewModel: RoadmapViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        addChart()
    }

    @objc func generateChartButtonPressed() {
        viewModel?.sendRequest(date: datePicker.date)
        generateChart()
    }

    private func setUpViews() {
        ganttChartView.isHidden = true
        view.addSubview(ganttChartView)
        view.addSubview(datePicker)
        view.addSubview(generateButton)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            datePicker.trailingAnchor.constraint(equalTo: generateButton.trailingAnchor),
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            generateButton.heightAnchor.constraint(equalToConstant: 50),
            generateButton.widthAnchor.constraint(equalTo: datePicker.widthAnchor),
            generateButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            generateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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

    private func generateChart() {
        animateGeneration()
        bindChartItems()
    }

    private func animateGeneration() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.datePicker.alpha = 0
            self?.generateButton.alpha = 0
        }, completion: { [weak self] _ in
            self?.datePicker.isHidden = true
            self?.generateButton.isHidden = true
            self?.ganttChartView.isHidden = false
            self?.animateLoading()
        })
    }

    private func animateLoading() {
        let loadingAnimation = LoadingAnimationView(frame: .init(x: 0, y: 0, width: 300, height: 300))
        loadingAnimation.center = view.center
        view.addSubview(loadingAnimation)

        viewModel?.dataSubject
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .loading:
                    loadingAnimation.play()
                    return

                case .reloadData, .error:
                    loadingAnimation.stop()
                    UIView.animate(withDuration: 0.5, animations: {
                        loadingAnimation.alpha = 0
                    }, completion: { _ in
                        loadingAnimation.isHidden = true
                    })
                }
            }.store(in: &cancellables)
    }

    private func bindChartItems() {
        viewModel?.dataSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case let .reloadData(items):
                    self?.reloadChart(items)
                default:
                    return
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
