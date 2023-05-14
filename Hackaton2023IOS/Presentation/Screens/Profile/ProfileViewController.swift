//
//  MyProfileViewController.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit
import Combine

final class ProfileViewController: UIViewController, StoryboardInstantiable {
    var viewModel: ProfileViewModel? {
        didSet {
            handleUserSubjectChanged()
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private var tableView: ProfileTableView?
    private var profileViewControllerTableModel: ProfileViewControllerTableModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        handleUserSubjectChanged()
    }
}

private extension ProfileViewController {

    func createTableView() {
        profileViewControllerTableModel = ProfileViewControllerTableModel()
        tableView = ProfileTableView(frame: view.frame, style: .insetGrouped)
        if let tableView = tableView {
            profileViewControllerTableModel?.profileTableView = tableView
            tableView.dataSource = profileViewControllerTableModel
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            ])
        }
    }

    func createHeaderView(user: User) -> UIView {
        let nameLabel = UILabel()
        nameLabel.text = "First Name: \(user.firstName)\nLast Name: \(user.lastName)"
        let titleLabel = UILabel()
        titleLabel.text = "Current Title: \(user.title)\nDesired Title: \(user.desiredTitle)"
        let stackView = UIStackView(arrangedSubviews: [nameLabel, titleLabel])
        return stackView
    }

    func handleUserSubjectChanged() {
        viewModel?.userSubject.sink(receiveValue: { [weak self] user in
           guard let user = user else {
               return
           }
            self?.tableView?.tableHeaderView = self?.createHeaderView(user: user)
            self?.tableView?.builder = SectionInfoBuilder(user: user)
            self?.tableView?.reloadData()
       }).store(in: &cancellables)
    }
}
