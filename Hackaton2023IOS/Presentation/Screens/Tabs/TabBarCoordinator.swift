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
    private var myProfileCoordinator: ProfileCoordinator?
    private let peopleSearchNavigationController: UINavigationController
    private var peopleSearchCoordinator: PeopleSearchCoordinator?
    private let historyNavigationController: UINavigationController
    private var historyCoordinator: HistoryCoordinator?

    init(presenter: UIViewController) {
        self.presenter = presenter
        myProfileNavigationController = UINavigationController()
        peopleSearchNavigationController = UINavigationController()
        historyNavigationController = UINavigationController()
        viewControllersInPresenter = [
            myProfileNavigationController,
            peopleSearchNavigationController,
            historyNavigationController
        ]
        tabViewController = UITabBarController()
        tabViewController.tabBar.barTintColor = .black
        tabViewController.tabBar.backgroundColor = .white
    }

    func start() {
        tabViewController.modalPresentationStyle = .fullScreen
        presenter.present(tabViewController, animated: false)
        tabViewController.viewControllers = viewControllersInPresenter

        myProfileNavigationController.tabBarItem = UITabBarItem(title: "My profile", image: nil, selectedImage: nil)
        myProfileCoordinator = ProfileCoordinator(presenter: myProfileNavigationController)
        myProfileCoordinator?.start()

        peopleSearchNavigationController.tabBarItem = UITabBarItem(
            title: "People search",
            image: nil,
            selectedImage: nil
        )
        peopleSearchNavigationController.navigationBar.backgroundColor = .white
        peopleSearchCoordinator = PeopleSearchCoordinator(presenter: peopleSearchNavigationController)
        peopleSearchCoordinator?.start()

        historyNavigationController.tabBarItem = UITabBarItem(title: "History", image: nil, selectedImage: nil)
        historyCoordinator = HistoryCoordinator(presenter: historyNavigationController)
        historyCoordinator?.start()
    }
}
