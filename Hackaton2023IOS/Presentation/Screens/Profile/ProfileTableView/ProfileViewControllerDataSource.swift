//
//  ProfileViewControllerDataSource.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import UIKit

final class ProfileViewControllerDataSource: NSObject, UITableViewDataSource {

    var profileTableView: ProfileTableView?

    func numberOfSections(in tableView: UITableView) -> Int {
        profileTableView?.sectionInfo.count ?? .zero
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileTableView?.sectionInfo[section].cells.count ?? .zero
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        profileTableView?.sectionInfo[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionInfo = profileTableView?.sectionInfo else {
            return UITableViewCell()
        }
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let row = sectionInfo[indexPath.section].cells[indexPath.row]
        var configuration = cell.defaultContentConfiguration()

        if row.title.isEmpty {
            configuration.text = row.value
        } else {
            configuration.text =  "\(row.title):"
            configuration.secondaryText = row.value
        }
        configuration.textProperties.color = .black
        configuration.secondaryTextProperties.color = .black
        cell.contentConfiguration = configuration
        return cell
    }
}
