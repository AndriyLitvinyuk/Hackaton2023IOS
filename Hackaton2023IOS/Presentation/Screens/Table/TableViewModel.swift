//
//  TableViewModel.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import Foundation
import Combine

final class TableViewModel {
    let schedule: CurrentValueSubject<[ScheduleResponse]?, Never>

    init() {
        self.schedule = UserInfoSingleton.shared.schedule
    }
}
