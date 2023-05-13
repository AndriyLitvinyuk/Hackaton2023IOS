//
//  StoryboardInstantiable.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

protocol StoryboardInstantiable: DefaultFileName {
    static func instantiateViewController(_ bundle: Bundle?) -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        // swiftlint:disable:next identifier_name
        let sb = UIStoryboard(name: defaultFileName, bundle: bundle)
        // swiftlint:disable:next force_cast
        return sb.instantiateInitialViewController() as! Self
    }
}
