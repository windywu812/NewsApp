//
//  HighlightCell.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

class LargeCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "HighlightCell"
    
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            dateLabel.text = article.publishedAt?.changeDateFormat()
            if let imageURL = article.urlToImage {
                imageView.setImage(urlString: imageURL)
            }
        }
    }
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
