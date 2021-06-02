//
//  NoteCollectionViewListCell.swift
//  CloudNotes
//
//  Created by Ryan-Son on 2021/06/02.
//

import UIKit

final class NoteCollectionViewListCell: UICollectionViewListCell {
    static let reuseIdentifier: String = "NoteCollectionViewListCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    var lastModifiedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .gray
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    func configure(with note: Note) {
        let secondaryStackView = getStackViewForSecondaryLabels(with: [lastModifiedLabel, bodyLabel])
        let entireContentsStackView = getStackViewForEntireContents(with: [titleLabel, secondaryStackView])
        self.accessories = [.disclosureIndicator()]
        
        self.addSubview(entireContentsStackView)
        
        NSLayoutConstraint.activate([
            entireContentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            entireContentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            entireContentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            entireContentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        let lastModifiedDate = Date(timeIntervalSince1970: TimeInterval(note.lastModified))
        
        titleLabel.text = note.title
        lastModifiedLabel.text = "\(lastModifiedDate.formatByLocalePreference)"
        bodyLabel.text = note.body
    }
    
    func getStackViewForSecondaryLabels(with subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }
    
    func getStackViewForEntireContents(with subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }
}

extension Date {
    var formatByLocalePreference: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("yyyy. MM. dd.")
        return formatter.string(from: self)
    }
}
