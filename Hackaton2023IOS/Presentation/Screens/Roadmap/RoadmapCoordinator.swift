//
//  PeopleSearchCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class RoadmapCoordinator: Coordinator {
    private let presenter: UINavigationController
    private weak var viewController: RoadmapViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let viewController = RoadmapViewController.instantiateViewController()
        viewController.viewModel = RoadmapViewModel()
        viewController.viewModel?.sendRequest(date: Date(timeIntervalSinceNow: 800000))
        presenter.pushViewController(viewController, animated: false)
        self.viewController = viewController
    }
}
