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

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = PeopleSearchViewController.instantiateViewController()
        presenter.pushViewController(viewController, animated: false)
        self.viewController = viewController
    }
}
