//
//  UINavigationController+Extensions.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

extension UINavigationController {
    static func defaultNavigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.navigationBar.isHidden = true
        return navController
    }
}
