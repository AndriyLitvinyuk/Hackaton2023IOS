//
//  UserProfileViewModel.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//
import Combine
import UIKit

final class ProfileViewModel {
    private var cancellables = Set<AnyCancellable>()
    var userSubject = CurrentValueSubject<User?, Never>(nil)

    init(user: User) {
        UserInfoSingleton.shared.user = user
        userSubject.send(user)
    }

    private func saveUser() {
        userSubject.sink { value in
            UserInfoSingleton.shared.user = value
        }.store(in: &cancellables)
    }
}

final class UserInfoSingleton {
    static let shared = UserInfoSingleton(user: nil)

    var user: User?
    let schedule = CurrentValueSubject<[ScheduleResponse]?, Never>(nil)

    private init(user: User?) {
        self.user = user
    }
}
