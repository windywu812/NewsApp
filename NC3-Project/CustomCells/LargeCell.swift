//
//  HighlightCell.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

class LargeCell: UICollectionViewCell, ConfigureCellProtocol {
    
    static var reuseIdentifier: String = "HighlightCell"
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(article: Article) {
        titleLabel.text = article.title
        dateLabel.text = article.publishedAt?.changeDateFormat()
        if let imageURL = article.urlToImage {
            imageView.setImage(urlString: imageURL)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
