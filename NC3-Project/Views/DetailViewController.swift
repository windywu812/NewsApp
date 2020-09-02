//
//  DetailViewController.swift
//  NC3-Project
//
//  Created by Windy on 02/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
        
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            authorLabel.text = article.author
            dateLabel.text = article.publishedAt
            imageView.setImage(urlString: article.urlToImage ?? "")
            contentLabel.text = article.description
        }
    }
    
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let dateLabel = UILabel()
    let imageView = UIImageView()
    let contentLabel = UILabel()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.font = .preferredFont(forTextStyle: .footnote)
        authorLabel.textColor = .secondaryLabel
        
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemRed
        scrollView.addSubview(imageView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        contentLabel.font = .preferredFont(forTextStyle: .body)
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentLabel)
        
        button.setTitle("Read more", for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(button)
        
        let safeArea = view.safeAreaLayoutGuide
        let margin = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margin.trailingAnchor),

            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            contentLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            
            button.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            button.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 0),
            button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
    @objc private func handleTap() {
        if let url = URL(string: article.url ?? "") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

}
