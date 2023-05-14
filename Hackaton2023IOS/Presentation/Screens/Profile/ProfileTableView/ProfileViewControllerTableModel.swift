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
        let cell = UITableViewCell(
            style: sectionInfo[indexPath.section].style.cellStyleVariant,
            reuseIdentifier: "UITableViewCell"
        )
        let row = sectionInfo[indexPath.section].cells[indexPath.row]
        var configuration = cell.defaultContentConfiguration()

        if row.title.isEmpty {
            configuration.text = row.value
        } else {
            configuration.text =  (row.value)
            configuration.secondaryText = row.title
        }
        configuration.textProperties.color = .black
        configuration.secondaryTextProperties.color = .gray
        cell.contentConfiguration = configuration
        cell.isUserInteractionEnabled = row.isInteractionEnabled
        return cell
    }
}

extension ProfileViewControllerTableModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard  let cell = profileTableView?.sectionInfo[indexPath.section].cells[indexPath.row],
               let url = URL(string: cell.value),
               UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url)

    }
}

private extension Style {
    var cellStyleVariant: UITableViewCell.CellStyle {
        switch self {
        case .standard:
            return .default
        case .oneLine:
            return .value1
        case .subtitle:
            return .subtitle
        }
    }
}
