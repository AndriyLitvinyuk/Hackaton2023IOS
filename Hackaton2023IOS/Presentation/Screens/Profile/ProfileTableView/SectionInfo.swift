//
//  SectionInfo.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct SectionInfo {
    struct Cell {
        let title: String
        let value: String
        let isInteractionEnabled: Bool

        init(title: String, value: String, isInteractionEnabled: Bool = false) {
            self.title = title
            self.value = value
            self.isInteractionEnabled = isInteractionEnabled
        }
    }
    let title: String
    let cells: [Cell]
    let style: Style

    init(title: String, cells: [Cell], style: Style = .standard) {
        self.title = title
        self.cells = cells
        self.style = style
    }
}

enum Style {
    case standard
    case oneLine
    case subtitle
}
