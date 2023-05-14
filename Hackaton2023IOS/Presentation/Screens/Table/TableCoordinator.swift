//
//  TableCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class TableCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var viewController: TableViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = TableViewController.instantiateViewController()
        viewController.viewModel = TableViewModel()
        presenter.pushViewController(viewController, animated: false)
        self.viewController = viewController
    }
}
