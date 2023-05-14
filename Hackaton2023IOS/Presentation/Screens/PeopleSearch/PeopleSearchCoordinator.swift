//
//  PeopleSearchCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class PeopleSearchCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var viewController: PeopleSearchViewController?
    private var profileCoordinator: ProfileCoordinator?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = PeopleSearchViewController.instantiateViewController()
        viewController.viewModel = PeopleSearchViewModel()
        presenter.pushViewController(viewController, animated: false)
        viewController.delegate = self
        self.viewController = viewController
    }
}

// MARK: - PeopleSearchViewControllerDelegate

extension PeopleSearchCoordinator: PeopleSearchViewControllerDelegate {
    func selectedProfile(profile: User) {
        profileCoordinator = ProfileCoordinator(presenter: presenter)
        profileCoordinator?.start()
    }
}
