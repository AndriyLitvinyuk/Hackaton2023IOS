//
//  ViewController.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 12.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Example
        let searchAnimation = SearchAnimationView(frame: .init(x: 0, y: 0, width: 400, height: 400))
        searchAnimation.center = view.center
        view.addSubview(searchAnimation)
        searchAnimation.play()
    }
}
