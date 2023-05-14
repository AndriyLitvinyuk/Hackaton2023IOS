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
    private var peopleSearchCoordinator: RoadmapCoordinator?

    init(presenter: UIViewController) {
        self.presenter = presenter
        myProfileNavigationController = UINavigationController.defaultNavigationController()
        peopleSearchNavigationController = UINavigationController.defaultNavigationController()
        viewControllersInPresenter = [
            myProfileNavigationController,
            peopleSearchNavigationController
        ]
        tabViewController = Self.createTabBar()
    }

    private static func createTabBar() -> UITabBarController {
        let tabViewController = UITabBarController()
        tabViewController.tabBar.barTintColor = .black
        tabViewController.tabBar.backgroundColor = .white
        tabViewController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabViewController.tabBar.layer.shadowRadius = 6
        tabViewController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabViewController.tabBar.layer.shadowOpacity = 0.3
        tabViewController.tabBar.tintColor = .primaryColor
        tabViewController.modalPresentationStyle = .fullScreen
        return tabViewController
    }

    func start() {
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
        peopleSearchCoordinator = RoadmapCoordinator(presenter: peopleSearchNavigationController)
        peopleSearchCoordinator?.start()
        tabViewController.selectedIndex = 1
    }
}
