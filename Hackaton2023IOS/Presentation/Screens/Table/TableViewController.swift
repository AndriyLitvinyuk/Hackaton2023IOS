//
//  TableViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import Combine

final class TableViewController: UIViewController, StoryboardInstantiable {
    var viewModel: TableViewModel?
    private var cancellables = Set<AnyCancellable>()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        bindViewModel()
    }

    private func setUpViews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel?.schedule.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] _ in
            self?.tableView.reloadData()
        }).store(in: &cancellables)
    }
}

extension TableViewController: UITableViewDataSource {
    var sections: [ScheduleResponse]? {
        viewModel?.schedule.value
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections?[section].subCategories.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections?[section].category
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections else {
            return UITableViewCell()
        }
        let cell = ScheduleTableViewCell()
        cell.applyCell(subCategory: sections[indexPath.section].subCategories[indexPath.row])
        return cell
    }
}
