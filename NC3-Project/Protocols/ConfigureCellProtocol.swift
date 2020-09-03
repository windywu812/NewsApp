//
//  ConfigureCellProtocol.swift
//  NC3-Project
//
//  Created by Windy on 03/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Foundation

protocol ConfigureCellProtocol {
    static var reuseIdentifier: String { get }
    func configure(article: Article)
}
