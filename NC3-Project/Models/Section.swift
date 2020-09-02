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
    case technology
    case health
    case science
    case sports
    
    var string: String {
        switch self {
        case .topHeadline:
            return "Top Headlines"
        case .business:
            return "Business"
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
