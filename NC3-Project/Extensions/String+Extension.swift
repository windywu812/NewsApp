//
//  String+Extensino.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import Foundation

extension String {
    
    func changeDateFormat() -> String? {
        
        let formatterFromJSON = ISO8601DateFormatter()
        
        let date = formatterFromJSON.date(from: self)
        
        let formatterToDate = DateFormatter()
        formatterToDate.dateStyle = .full
        
        if let date = date {
            return formatterToDate.string(from: date)
        }
        
        return nil
    }
    
}
