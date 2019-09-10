//
//  Show.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

struct Show: Codable {
    
    let show: ShowWrapper
    
    
    struct ShowWrapper: Codable {
        let id: Int
        let name: String
        let image: ImageWrapper?
        let rating: Rating?
    }
    
    struct ImageWrapper: Codable {
        let medium: String
        let original: String
    }
    
    struct Rating: Codable {
        let average: Double?
    }
    
    
    static func getShowData(searchString: String?, completionHandler: @escaping (Result<[Show],AppError>) -> () ) {
        var url = "http://api.tvmaze.com/search/shows?q=girls"
        
        if let searchString = searchString?.replacingOccurrences(of: " ", with: "-") {
            url = "http://api.tvmaze.com/search/shows?q=\(searchString)"
        }
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showResults = try JSONDecoder().decode([Show].self, from: data)
                    
                    completionHandler(.success(showResults))
                } catch {
                    print(error)
                    completionHandler(.failure(.badJSONError))
                }
            }
            
        }
    }
}

