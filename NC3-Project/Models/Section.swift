//
//  Sectin.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Foundation

enum Section: String {
    case topHeadline
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
    
    var string: String {
        switch self {
        case .topHeadline:
            return "Top Headlines"
        case .business:
            return "Business"
        case .general:
            return "General"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
}
