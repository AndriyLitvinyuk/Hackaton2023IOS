//
//  SectionInfoBuilder.swift
//  Hackaton2023IOS
//
//  Created by Oleksandr Bondar3 on 13.05.2023.
//

import Foundation

struct SectionInfoBuilder {

    private let user: User

    init(user: User) {
        self.user = user
    }

    func build() -> [SectionInfo] {
        mapUser(user: user)
    }
}

private extension SectionInfoBuilder {

    func mapUser(user: User) -> [SectionInfo] {
        [
            [
                .init(title: "Personal Info", cells: [
                    .textCell("Name", user.firstName + " " + user.lastName),
                    .textCell("Current Title", user.title),
                    .textCell("Desired Title", user.desiredTitle)
                ])
            ],
            user.categories.map {
                SectionInfo(
                    title: $0.category, cells: $0.subCategories.map {
                        .subCategoryCell($0)
                    }
                )
            }
        ].flatMap { $0 }
    }
}
