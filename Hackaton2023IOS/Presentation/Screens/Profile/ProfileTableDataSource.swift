//
//  ProfileTableDataSource.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//

import UIKit

final class ProfileTableDataSource: NSObject, UITableViewDataSource {

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
    override init() {
        super.init()
    }

    init(user: User) {
        super.init()
    }
}
