//
//  ArticleViewModel.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Combine

class ArticleViewModel {
    
    @Published var highlightArticles: [Article] = []
    @Published var generalArticles: [Article] = []
    
    var highLightCancellable: AnyCancellable!
    var generalCancellable: AnyCancellable!
    
    init() {
        highLightCancellable = Networking.fetchData(category: nil)
        .sink(receiveCompletion: { (completion) in
            
        }, receiveValue: { (news) in
            self.highlightArticles = news.articles ?? []
        })
        
        generalCancellable = Networking.fetchData(category: Section.general)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }, receiveValue: { (news) in
                self.generalArticles = news.articles ?? []
            })
    }
    
}
