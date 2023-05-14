//
//  ScheduleTableViewCell.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            subCategoryLabel,
            startTimeLabel,
            endTimeLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let subCategoryLabel = UILabel()
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        subCategoryLabel.font = .boldSystemFont(ofSize: subCategoryLabel.font.pointSize)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyCell(subCategory: ScheduleResponse.Subcategory) {
        subCategoryLabel.text = subCategory.subCategory
        let startTimeString = NSMutableAttributedString()
        startTimeString.append(.init(string: "Start Time: ", attributes: [.foregroundColor: UIColor.gray]))
        startTimeString.append(.init(string: subCategory.start))
        startTimeLabel.attributedText = startTimeString
        let endTimeString = NSMutableAttributedString()
        endTimeString.append(.init(string: "End Time: ", attributes: [.foregroundColor: UIColor.gray]))
        endTimeString.append(.init(string: subCategory.end))
        endTimeLabel.attributedText = endTimeString
    }
}
