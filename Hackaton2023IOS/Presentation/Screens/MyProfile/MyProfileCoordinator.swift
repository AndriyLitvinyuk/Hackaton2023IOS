//
//  MyProfileCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

class MyProfileCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var viewController: MyProfileViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = MyProfileViewController.instantiateViewController()
        presenter.pushViewController(viewController, animated: false)
        self.viewController = viewController
    }
}
