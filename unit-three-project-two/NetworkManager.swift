//
//  NetworkManager.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

class NetworkManager {
    //TODO: - update this to cache
    private init() {}
    static let shared = NetworkManager()
    
    //Performs GET requests for any URL
    //Parameters: URL as a string
    //Completion: Result with Data in success and AppError in failure
    
    func fetchData(urlString: String, completionHandler: @escaping (Result<Data,AppError>) -> () ) {
        guard let url = URL(string: urlString) else {completionHandler(.failure(.badURLError))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {completionHandler(.failure(.networkError))
                return
            }
            guard let data = data else {completionHandler(.failure(.noDataError))
                return
            }
            guard let response = response as? HTTPURLResponse else {completionHandler(.failure(.badHTTPError))
                return
            }
            switch response.statusCode {
            case 404:
                completionHandler(.failure(.notFound))
            case 401, 403:
                completionHandler(.failure(.unAuthorized))
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.other(errorDescription: "Wrong Status Code")))
            }
            }.resume()
    }
}
