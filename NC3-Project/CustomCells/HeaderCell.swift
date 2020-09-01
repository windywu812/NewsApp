//
//  HeaderCell.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = .label
        title.font = .preferredFont(forTextStyle: .title3)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .tertiaryLabel
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            title.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 8)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
