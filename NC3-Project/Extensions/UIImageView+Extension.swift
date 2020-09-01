//
//  UIImageView+Extension.swift
//  NC3-Project
//
//  Created by Windy on 01/09/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let imageFromCache = Networking.imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        Networking.loadImage(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                Networking.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                self.image = UIImage(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

