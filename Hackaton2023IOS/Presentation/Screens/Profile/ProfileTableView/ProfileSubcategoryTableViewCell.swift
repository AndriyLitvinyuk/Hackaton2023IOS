//
//  ProfileSubcategoryTableViewCell.swift
//  Hackaton2023IOS
//
//  Created by Andrii Lytvyniuk on 14.05.2023.
//

import UIKit

final class ProfileSubcategoryTableViewCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            categoryLabel,
            currentLevel,
            desiredLevel
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 6
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.setCustomSpacing(8, after: categoryLabel)
        return stackView
    }()

    private lazy var categoryLabel = UILabel()
    private lazy var currentLevel = LevelStackView()
    private lazy var desiredLevel = LevelStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        categoryLabel.font = .boldSystemFont(ofSize: categoryLabel.font.pointSize)
        categoryLabel.numberOfLines = 0
        categoryLabel.sizeToFit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyCell(subCategory: Category.SubCategory) {
        categoryLabel.text = subCategory.subCategory
        currentLevel.titleText = "Current Level:"
        currentLevel.levelText = subCategory.current
        desiredLevel.titleText = "Desired Level:"
        desiredLevel.levelText = subCategory.required
    }
}

final class LevelStackView: UIStackView {
    private lazy var titleLabel = UILabel()
    private lazy var levelLabel = UILabel()

    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    var levelText: String? {
        didSet {
            levelLabel.text = levelText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.textColor = .gray
        addArrangedSubview(titleLabel)
        addArrangedSubview(levelLabel)
        axis = .horizontal
        distribution = .fillEqually
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
