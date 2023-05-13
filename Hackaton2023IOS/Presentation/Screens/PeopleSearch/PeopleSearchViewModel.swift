//
//  PeopleSearchViewModel.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import Combine

class PeopleSearchViewModel {
    var reloadSubject = CurrentValueSubject<Void, Never>(())
    var profiles: [User] = []

    func search(promt: String) {
        profiles = Array.init(repeating: User.defaultUser, count: 15)
        reloadSubject.send(())
    }
    
    func cellModelFor(_ index: Int) -> PeopleSearchCellModel {
        let user = profiles[index]
        return PeopleSearchCellModel(
            name: user.personalInfo.firstName + " " + user.personalInfo.lastName,
            title: user.organizationalAttributes.title,
            skils: user.skills.map { $0.skill }.reduce("Skils:", { $0 + ", " + $1 })
        )
    }

    func cancel() {
        profiles = []
        reloadSubject.send(())
    }
}
