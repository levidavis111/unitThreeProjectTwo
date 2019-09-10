//
//  Episode.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/10/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

class Episode: Codable {
    
    
    let name: String?
    let season: Int?
    let number: Int?
    let image: Image?
    let summary: String?
    var cleanSummary: String {
        get {
            return summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? ""
        }
    }
    
    struct Image: Codable {
        let medium: String
        let original: String
    }
    
    static func getEpisodeData(showID: Int, completionHandler: @escaping (Result<[Episode],AppError>) -> () ) {
        let url = "http://api.tvmaze.com/shows/\(showID)/episodes"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let episodeResults = try JSONDecoder().decode([Episode].self, from: data)
                    
                    completionHandler(.success(episodeResults))
                } catch {
                    print(error)
                    completionHandler(.failure(.badJSONError))
                }
            }
        }
    }
}
