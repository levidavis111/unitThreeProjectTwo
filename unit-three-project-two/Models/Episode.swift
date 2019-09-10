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
    
    
//    static func getShowData(searchString: String?, completionHandler: @escaping (Result<[Show],AppError>) -> () ) {
//        var url = "http://api.tvmaze.com/shows/139/episodes"
//
//        if let searchString = searchString?.replacingOccurrences(of: " ", with: "-") {
//            url = "http://api.tvmaze.com/search/shows?q=\(searchString)"
//        }
//
//        NetworkManager.shared.fetchData(urlString: url) { (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(error))
//            case .success(let data):
//                do {
//                    let showResults = try JSONDecoder().decode([Show].self, from: data)
//
//                    completionHandler(.success(showResults))
//                } catch {
//                    print(error)
//                    completionHandler(.failure(.badJSONError))
//                }
//            }
//
//        }
//    }
}

//{
//    "id": 10820,
//    "url": "http://www.tvmaze.com/episodes/10820/girls-1x01-pilot",
//    "name": "Pilot",
//    "season": 1,
//    "number": 1,
//    "airdate": "2012-04-15",
//    "airtime": "22:30",
//    "airstamp": "2012-04-16T02:30:00+00:00",
//    "runtime": 30,
//    "image": {
//        "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/15/38639.jpg",
//        "original": "http://static.tvmaze.com/uploads/images/original_untouched/15/38639.jpg"
//    },
//    "summary": "<p>In the premiere of this comedy about twentysomething women navigating their way through life in New York, Hannah swings and misses at two curves when her parents rescind their financial support and she loses her unpaid internship. Meanwhile, Hannah's roommate, Marnie, throws a dinner party for their nomadic friend Jessa, who's returned from yet another journey.</p>",
//    "_links": {
//        "self": {
//            "href": "http://api.tvmaze.com/episodes/10820"
//        }
//    }
//},
//{
//    "id": 10821,
//    "url": "http://www.tvmaze.com/episodes/10821/girls-1x02-vagina-panic",
//    "name": "Vagina Panic",
//    "season": 1,
//    "number": 2,
//    "airdate": "2012-04-22",
//    "airtime": "22:30",
//    "airstamp": "2012-04-23T02:30:00+00:00",
//    "runtime": 30,
//    "image": {
//        "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/15/38640.jpg",
//        "original": "http://static.tvmaze.com/uploads/images/original_untouched/15/38640.jpg"
//    },
//    "summary": "<p>An appointment at a women's clinic doesn't go according to Marnie's detailed plans, mostly because Jessa will find any reason not to show up. Meanwhile, Hannah is preoccupied by an STD scare; and Shoshanna makes a startling revelation.</p>",
//    "_links": {
//        "self": {
//            "href": "http://api.tvmaze.com/episodes/10821"
//        }
//    }
//},
//{
//    "id": 10822,
//    "url": "http://www.tvmaze.com/episodes/10822/girls-1x03-all-adventurous-women-do",
//    "name": "All Adventurous Women Do",
//    "season": 1,
//    "number": 3,
//    "airdate": "2012-04-29",
//    "airtime": "22:30",
//    "airstamp": "2012-04-30T02:30:00+00:00",
//    "runtime": 30,
//    "image": {
//        "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/15/38641.jpg",
//        "original": "http://static.tvmaze.com/uploads/images/original_untouched/15/38641.jpg"
//    },
//    "summary": "<p>Hannah contacts her college boyfriend to find out how she contracted an STD, but learns perhaps even more shocking news from him. Meanwhile, Marnie is smitten with a pretentious artist at a gallery opening; and Jessa lands a babysitting job.</p>",
//    "_links": {
//        "self": {
//            "href": "http://api.tvmaze.com/episodes/10822"
//        }
//    }
//},
//{
//    "id": 10823,
//    "url": "http://www.tvmaze.com/episodes/10823/girls-1x04-hannahs-diary",
//    "name": "Hannah's Diary",
//    "season": 1,
//    "number": 4,
//    "airdate": "2012-05-06",
//    "airtime": "22:30",
//    "airstamp": "2012-05-07T02:30:00+00:00",
//    "runtime": 30,
//    "image": {
//        "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/15/38642.jpg",
//        "original": "http://static.tvmaze.com/uploads/images/original_untouched/15/38642.jpg"
//    },
//    "summary": "<p>Adam's risqué text message sends Hannah over the edge; Jessa gets distracted while babysitting; Shoshanna reunites with a guy she knew at camp; Ray and Charlie stick their noses where they don't belong.</p>",
//    "_links": {
//        "self": {
//            "href": "http://api.tvmaze.com/episodes/10823"
//        }
//    }
//}
