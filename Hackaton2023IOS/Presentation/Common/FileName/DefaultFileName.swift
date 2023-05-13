//
//  DefaultFileName.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import Foundation

protocol DefaultFileName: NSObject {
    static var defaultFileName: String { get }
}

extension DefaultFileName {
    static var defaultFileName: String {
        // swiftlint:disable:next force_unwrapping
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
}
