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
    @Published var healthToken: [Article] = []
    @Published var scienceToken: [Article] = []
    @Published var sportsToken: [Article] = []
    @Published var entertainmentToken: [Article] = []

    var cancellables: [AnyCancellable]!
    
    var headline: [Article] = []
    var business: [Article] = []
    var technology: [Article] = []
    var health: [Article] = []
    var science: [Article] = []
    var sports: [Article] = []
    var entertainment: [Article] = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        cancellables = [
            Networking.fetchData(category: nil)
                .sink(receiveCompletion: { (completion) in
                    print(completion)
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
                }, receiveValue: { (news) in
                    self.technologyToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.health)
                .sink(receiveCompletion: { (completion) in
                }, receiveValue: { (news) in
                    self.healthToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.science)
                .sink(receiveCompletion: { (completion) in
                }, receiveValue: { (news) in
                    self.scienceToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.sports)
                .sink(receiveCompletion: { (completion) in
                }, receiveValue: { (news) in
                    self.sportsToken = news.articles ?? []
                }),
            Networking.fetchData(category: Section.entertainment)
                .sink(receiveCompletion: { (completion) in
                }, receiveValue: { (news) in
                    self.entertainmentToken = news.articles ?? []
                })
        ]
    }
    
}
