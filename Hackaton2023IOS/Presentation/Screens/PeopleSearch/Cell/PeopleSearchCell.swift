//
//  PeopleSearchCell.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class PeopleSearchCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func setupCell(model: PeopleSearchCellModel) {
        backgroundColor = .red
        titleLabel.text = model.title
    }
}
