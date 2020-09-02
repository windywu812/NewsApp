//
//  News.swift
//  NC3-Project
//
//  Created by Windy on 29/08/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Foundation

struct News: Decodable, Hashable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Decodable, Hashable {
    let id = UUID()
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
