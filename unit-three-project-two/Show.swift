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
    let image: ImageWrapper
    
    
    struct ShowWrapper: Codable {
        let id: Int
        let url: String
        let name: String
    }
    
    struct ImageWrapper: Codable {
        let medium: String
        let original: String
    }
    
    
    static func getShowData(completionHandler: @escaping (Result<[Show],AppError>) -> () ) {
        let url = "http://api.tvmaze.com/search/shows?q=girls"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showResults = try JSONDecoder().decode(Show.self, from: data)
                    
                    completionHandler(.success([showResults]))
                } catch {
                    completionHandler(.failure(.badJSONError))
                }
            }
            
        }
    }
}
