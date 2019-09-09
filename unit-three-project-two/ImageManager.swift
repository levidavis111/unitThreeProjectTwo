//
//  ImageManager.swift
//  unit-three-project-two
//
//  Created by Levi Davis on 9/9/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init() {}
    static let shared = ImageHelper()
    
    func fetchImage(urlString: String, completionHandler: @escaping (Result<UIImage,AppError>) -> () ) {
        NetworkManager.shared.fetchData(urlString: urlString) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                guard let image = UIImage(data: data) else {completionHandler(.failure(.badImageData))
                    return
                }
                completionHandler(.success(image))
                
            }
        }
    }
}
