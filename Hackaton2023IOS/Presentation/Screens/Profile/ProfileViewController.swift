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
    private var profileViewControllerDataSource: ProfileViewControllerDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        handleUserSubjectChanged()
    }
}

private extension ProfileViewController {

    func createTableView() {
        profileViewControllerDataSource = ProfileViewControllerDataSource()
        tableView = ProfileTableView(frame: view.frame, style: .insetGrouped)
        if let tableView = tableView {
            profileViewControllerDataSource?.profileTableView = tableView
            tableView.allowsSelection = false
            tableView.dataSource = profileViewControllerDataSource
            view.addSubview(tableView)
        }
    }

    func handleUserSubjectChanged() {
        viewModel?.userSubject.sink(receiveValue: { [weak self] user in
           guard let user = user else {
               return
           }
            self?.tableView?.builder = SectionInfoBuilder(user: user)
            self?.tableView?.reloadData()
       }).store(in: &cancellables)
    }
}
