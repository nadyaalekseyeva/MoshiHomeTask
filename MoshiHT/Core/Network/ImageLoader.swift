//
//  ImageLoader.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class ImageLoader: ImageLoaderProtocol {
    
    func loadImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
    
}
