//
//  PeopleSearchCell.swift
//  Hackaton2023IOS
//
//  Created by Kostiantyn Koloskov on 13.05.2023.
//

import UIKit

final class PeopleSearchCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var skilsLabel: UILabel!

    func setupCell(model: PeopleSearchCellModel) {
        backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        nameLabel.text = model.name
        titleLabel.text = model.title
        skilsLabel.text = model.skils
    }
}
