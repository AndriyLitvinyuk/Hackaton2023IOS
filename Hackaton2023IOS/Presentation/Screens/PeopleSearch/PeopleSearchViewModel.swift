//
//  PeopleSearchViewModel.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import Combine

class PeopleSearchViewModel {
    var reloadSubject = CurrentValueSubject<Void, Never>(())
    var results: [PeopleSearchCellModel] = []

    func search(promt: String) {
        results = (1...15).map { _ in
            let user = User.defaultUser
            return PeopleSearchCellModel(
                name: user.personalInfo.firstName + " " + user.personalInfo.lastName,
                title: user.organizationalAttributes.title,
                skils: user.skills.map { $0.skill }.reduce("Skils:", { $0 + ", " + $1 })
            )
        }
        reloadSubject.send(())
    }

    func cancel() {
        results = []
        reloadSubject.send(())
    }
}
