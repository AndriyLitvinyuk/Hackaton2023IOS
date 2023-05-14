//
//  RoadmapViewModel.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 14.05.2023.
//

import Foundation
import Combine

final class RoadmapViewModel {
    var dataSubject = CurrentValueSubject<RoadmapData?, Never>(nil)
    
    func setRoadmap(_ data: RoadmapData) {
        dataSubject.send(data)
    }
}
