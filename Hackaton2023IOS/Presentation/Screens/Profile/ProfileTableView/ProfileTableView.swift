//
//  ProfileTableView.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 13.05.2023.
//

import UIKit

final class ProfileTableView: UITableView {

    var builder: SectionInfoBuilder?
    var sectionInfo: [SectionInfo] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reloadData() {
        sectionInfo = builder?.build() ?? []
        super.reloadData()
    }
}
