//
//  AppCoordinator.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

class AppCoorinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UIViewController
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UIViewController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        tabBarCoordinator = TabBarCoordinator(presenter: rootViewController)
        tabBarCoordinator?.start()
    }
}
