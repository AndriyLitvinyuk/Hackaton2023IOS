//
//  UserProfileViewModel.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//
import Combine
import UIKit

final class ProfileViewModel {
    var userSubject = CurrentValueSubject<User?, Never>(nil)
    init(user: User) {
        userSubject.send(user)
    }
}
