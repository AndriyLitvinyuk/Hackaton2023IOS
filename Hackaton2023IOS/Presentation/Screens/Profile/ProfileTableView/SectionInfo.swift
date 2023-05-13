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
    }
    let title: String
    let cells: [Cell]
}
