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
        myProfileNavigationController = UINavigationController.defaultNavigationController()
        peopleSearchNavigationController = UINavigationController.defaultNavigationController()
        historyNavigationController = UINavigationController.defaultNavigationController()
        viewControllersInPresenter = [
            myProfileNavigationController,
            peopleSearchNavigationController,
            historyNavigationController
        ]
        tabViewController = UITabBarController()
        tabViewController.tabBar.barTintColor = .black
        tabViewController.tabBar.backgroundColor = .white
        tabViewController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabViewController.tabBar.layer.shadowRadius = 6
        tabViewController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabViewController.tabBar.layer.shadowOpacity = 0.3
    }

    func start() {
        tabViewController.modalPresentationStyle = .fullScreen
        presenter.present(tabViewController, animated: false)
        tabViewController.viewControllers = viewControllersInPresenter

        myProfileNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil
        )
        myProfileCoordinator = ProfileCoordinator(presenter: myProfileNavigationController)
        myProfileCoordinator?.start()

        peopleSearchNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "chart.bar.doc.horizontal.fill"),
            selectedImage: nil
        )
        peopleSearchCoordinator = PeopleSearchCoordinator(presenter: peopleSearchNavigationController)
        peopleSearchCoordinator?.start()

        historyNavigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "archivebox.fill"),
            selectedImage: nil
        )
        historyCoordinator = HistoryCoordinator(presenter: historyNavigationController)
        tabViewController.selectedIndex = 1
        historyCoordinator?.start()
    }
}
