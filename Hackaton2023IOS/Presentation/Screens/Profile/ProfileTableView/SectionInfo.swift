//
//  SectionInfo.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct SectionInfo {
    enum Cell {
        case subCategoryCell(Category.SubCategory)
        case textCell(String, String)
    }
    let title: String
    let cells: [Cell]

    init(title: String, cells: [Cell]) {
        self.title = title
        self.cells = cells
    }
}

enum Style {
    case standard
    case oneLine
    case subtitle
}
