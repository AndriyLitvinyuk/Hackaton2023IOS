//
//  SearchAnivationView.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//

import Foundation
import Lottie

public final class SearchAnimationView: LottieAnimationView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadAnimation()
    }

    private func loadAnimation() {
        self.animation = LottieAnimation.asset("search-users")
        self.contentMode = .scaleAspectFit
        self.loopMode = .loop
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
