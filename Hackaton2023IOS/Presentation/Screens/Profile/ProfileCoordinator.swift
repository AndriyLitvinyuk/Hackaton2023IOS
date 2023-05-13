//
//  MyProfileCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var viewController: ProfileViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = ProfileViewController.instantiateViewController()
        viewController.viewModel = ProfileViewModel(user: User.defaultUser)
        presenter.pushViewController(viewController, animated: false)
        self.viewController = viewController
    }
}
