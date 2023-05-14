//
//  PeopleSearchViewModel.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import Dispatch
import Combine

class PeopleSearchViewModel {
    enum State {
        case idle
        case animating
        case reloadData
    }

    var stateSubject = CurrentValueSubject<State, Never>(.idle)
    var profiles: [User] = []

    func search(promt: String) {
        profiles = Array.init(repeating: User.defaultUser, count: 15)
        self.stateSubject.send(.animating)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.stateSubject.send(.reloadData)
        }
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
        stateSubject.send(.idle)
    }
}
