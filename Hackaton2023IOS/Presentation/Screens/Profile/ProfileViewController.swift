//
//  MyProfileViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController, StoryboardInstantiable {
    var viewModel: ProfileViewModel? {
        didSet {
            viewDidLoad()
        }
    }

    override func viewDidLoad() {
        guard let viewModel else {
            return
        }
        let tableView = ProfileTableView(frame: view.frame, style: .insetGrouped)
        tableView.dataSource = self
        view.addSubview(tableView)
        _ = viewModel.userSubject.sink(receiveValue: { user in
            tableView.user = user
            tableView.reloadData()
        })
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableView = tableView as? ProfileTableView else {
            return 0
        }
        return tableView.sectionInfo.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? ProfileTableView else {
            return 0
        }
        return tableView.sectionInfo[section].cells.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableView = tableView as? ProfileTableView else {
            return nil
        }
        return tableView.sectionInfo[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = tableView as? ProfileTableView else {
            return UITableViewCell()
        }
        let sectionInfo = tableView.sectionInfo
        let cell = UITableViewCell()
        let row = sectionInfo[indexPath.section].cells[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = row.title
        configuration.secondaryText = row.value
        configuration.textProperties.color = .black
        configuration.secondaryTextProperties.color = .black
        cell.contentConfiguration = configuration
        return cell
    }
}
