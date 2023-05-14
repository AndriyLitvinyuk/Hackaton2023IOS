//
//  ProfileViewControllerTableModel.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import UIKit

final class ProfileViewControllerTableModel: NSObject {
    var profileTableView: ProfileTableView?
}

extension ProfileViewControllerTableModel: UITableViewDataSource {
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
        let row = sectionInfo[indexPath.section].cells[indexPath.row]
        switch row {
        case .subCategoryCell(let subCategory):
            let cell = ProfileSubcategoryTableViewCell()
            cell.applyCell(subCategory: subCategory)
            cell.isUserInteractionEnabled = false
            return cell
        case .textCell(let title, let value):
            let cell = UITableViewCell()
            var configuration = cell.defaultContentConfiguration()
            configuration.text = value
            configuration.textProperties.color = .black
            configuration.secondaryText = title
            configuration.secondaryTextProperties.color = .gray
            cell.contentConfiguration = configuration
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
}

extension ProfileViewControllerTableModel: UITableViewDelegate {
}
