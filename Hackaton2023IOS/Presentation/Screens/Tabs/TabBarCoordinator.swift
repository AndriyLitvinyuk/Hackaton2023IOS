//
//  TabBarCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    private let presenter: UIViewController
    private let viewControllersInPresenter: [UIViewController]
    private let tabViewController: UITabBarController

    private let myProfileNavigationController: UINavigationController
    private var myProfileCoordinator: MyProfileCoordinator?
    private let searchNavigationController: UINavigationController
    private var searchCoordinator: SearchCoordinator?
    private let historyNavigationController: UINavigationController
    private var historyCoordinator: HistoryCoordinator?

    init(presenter: UIViewController) {
        self.presenter = presenter
        myProfileNavigationController = UINavigationController.defaultNavigationController()
        searchNavigationController = UINavigationController.defaultNavigationController()
        historyNavigationController = UINavigationController.defaultNavigationController()
        viewControllersInPresenter = [
            myProfileNavigationController,
            searchNavigationController,
            historyNavigationController
        ]
        tabViewController = UITabBarController()
        tabViewController.tabBar.barTintColor = .black
        tabViewController.tabBar.backgroundColor = .white
    }

    func start() {
        presenter.present(tabViewController, animated: false)
        tabViewController.viewControllers = viewControllersInPresenter

        myProfileNavigationController.tabBarItem = UITabBarItem(title: "My profile", image: nil, selectedImage: nil)
        myProfileCoordinator = MyProfileCoordinator(presenter: myProfileNavigationController)
        myProfileCoordinator?.start()

        searchNavigationController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        searchCoordinator = SearchCoordinator(presenter: searchNavigationController)
        searchCoordinator?.start()

        historyNavigationController.tabBarItem = UITabBarItem(title: "History", image: nil, selectedImage: nil)
        historyCoordinator = HistoryCoordinator(presenter: historyNavigationController)
        historyCoordinator?.start()
    }
}
