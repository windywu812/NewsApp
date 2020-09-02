//
//  DetailViewController.swift
//  NC3-Project
//
//  Created by Windy on 02/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
        
//    let author: String?
//      let title: String?
//      let description: String?
//      let url: String?
//      let urlToImage: String?
//      let publishedAt: String?
//      let content: String?
//
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            print(article.description)
        }
    }
    
    let scrollView = UIScrollView()
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let dateLabel = UILabel()
    let imageView = UIImageView()
    let contentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "ladjf;klasdjf;kasdfkja;dslfkja;sldkfj;dlaksfjal;ksdjfkl;adsjfal;skdjfals;kdfjakl;dsjfakls;jlkfadjl;kfalsdjfasdkjfak"
        authorLabel.text = "askldfslkdfsdlkfsd"
        dateLabel.text = ";alkdfsj;asldkfjas;lkdfja"
        contentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a est eget sapien dignissim tincidunt quis at nisi. Ut vitae leo imperdiet, suscipit ipsum nec, tempor lectus. Vestibulum interdum nec orci vitae consectetur. Donec ornare ut odio ac feugiat. Aliquam odio ex, fringilla eu vestibulum non, facilisis eget mi. Sed maximus commodo blandit. Nunc ornare maximus arcu quis lobortis. Morbi at augue vitae ante fermentum placerat. Sed a urna nunc. Sed volutpat varius arcu, ut fermentum tellus imperdiet ut. Mauris porta eros et massa hendrerit, non auctor arcu accumsan. Curabitur posuere, risus in pulvinar tempus, elit mauris pellentesque mi, vel sollicitudin sem sem ut tellus. Integer quis nisi nec felis vulputate interdum hendrerit et velit. Vestibulum ligula lectus, ultricies at aliquet rhoncus, hendrerit quis tellus. Curabitur fermentum gravida massa et sodales. Donec ante dui, tincidunt non tortor eu, cursus ullamcorper nibh. Mauris ac consequat velit. Donec ac molestie mauris, et feugiat neque. Nulla sit amet nunc in tellus varius interdum eu ut ex. Nullam sed nisi nec nulla interdum ornare. Cras eu ligula quis dui convallis ultricies eget in lorem. Fusce nisl lacus, mattis quis vulputate ac, placerat eget massa. Quisque feugiat hendrerit tortor sed eleifend. Pellentesque porttitor nisi nec."
        
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
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }

}
