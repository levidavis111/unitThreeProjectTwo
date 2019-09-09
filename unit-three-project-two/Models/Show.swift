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
    let image: ImageWrapper?
    
    struct ShowWrapper: Codable {
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

/*
 {
 "score": 17.373793,
 "show": {
 "id": 139,
 "url": "http://www.tvmaze.com/shows/139/girls",
 "name": "Girls",
 "type": "Scripted",
 "language": "English",
 "genres": [
 "Drama",
 "Romance"
 ],
 "status": "Ended",
 "runtime": 30,
 "premiered": "2012-04-15",
 "officialSite": "http://www.hbo.com/girls",
 "schedule": {
 "time": "22:00",
 "days": [
 "Sunday"
 ]
 },
 "rating": {
 "average": 6.9
 },
 "weight": 90,
 "network": {
 "id": 8,
 "name": "HBO",
 "country": {
 "name": "United States",
 "code": "US",
 "timezone": "America/New_York"
 }
 },
 "webChannel": null,
 "externals": {
 "tvrage": 30124,
 "thetvdb": 220411,
 "imdb": "tt1723816"
 },
 "image": {
 "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
 "original": "http://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
 },
 "summary": "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>",
 "updated": 1543140952,
 "_links": {
 "self": {
 "href": "http://api.tvmaze.com/shows/139"
 },
 "previousepisode": {
 "href": "http://api.tvmaze.com/episodes/1079686"
 }
 }
 }
 }
 */
