//
//  AppError.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badJSONError
    case networkError
    case noDataError
    case noResponse
    case badURLError
    case badHTTPError
    case notFound //404 status code
    case unAuthorized //401 and 403 error codes
    case badImageData
    case other(errorDescription: String)
    
}
