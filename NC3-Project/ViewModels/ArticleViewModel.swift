//
//  ArticleViewModel.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Combine

class ArticleViewModel {
    
    @Published var highlightToken: [Article] = []
    @Published var businessToken: [Article] = []
    @Published var technologyToken: [Article] = []
    
    var cancellables: [AnyCancellable]!
    
    var headline: [Article] = []
    var business: [Article] = []

    init() {
        cancellables = [
            Networking.fetchData(category: nil)
                .sink(receiveCompletion: { (completion) in
                    
                }, receiveValue: { (news) in
                    self.highlightToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.business)
                .sink(receiveCompletion: { (completion) in
                    
                }, receiveValue: { (news) in
                    self.businessToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.technology)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("success")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }, receiveValue: { (news) in
                    self
                })
        ]
    }
    
}
