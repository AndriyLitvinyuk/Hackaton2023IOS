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
        results = (1..<5).map {
            PeopleSearchCellModel(
                name: "Name last name",
                title: "Result number \($0)",
                skils: "Skils"
            )
            
        }
        reloadSubject.send(())
    }
}
