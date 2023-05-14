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
            tableView.delegate = profileViewControllerTableModel
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
