//
//  Services.swift
//  NC3-Project
//
//  Created by Windy on 29/08/20.
//  Copyright © 2020 Windy. All rights reserved.
//

import UIKit
import Combine

class Networking {
    
    /// Get your API KEY in https://newsapi.org
    static let API_KEY: String = "18db9968c5724d38975dd1208bd86288"

    static let imageCache = NSCache<AnyObject, AnyObject>()

    static func fetchData(country: String = "id", category: Section?) -> AnyPublisher<News, Error> {
        var urlComponent = URLComponents(string: "https://newsapi.org/v2/top-headlines")
        urlComponent?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "category", value: category?.rawValue),
            URLQueryItem(name: "apiKey", value: Networking.API_KEY)
        ]
        
        return URLSession.shared
            .dataTaskPublisher(for: (urlComponent?.url)!)
            .tryMap({ (element) -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            })
            .decode(type: News.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func loadImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    
}

