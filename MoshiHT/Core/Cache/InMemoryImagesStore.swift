//
//  InMemoryImageStore.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import Foundation
import UIKit

protocol ImagesStore {
    func getImage(url: URL) -> UIImage?
    func cache(image: UIImage, for: URL)
}

final class InMemoryImagesStore: ImagesStore {
    
    static let shared = InMemoryImagesStore()

    private init() {}
    
    private var images: [URL: UIImage] = [:]
    
    func getImage(url: URL) -> UIImage? {
        return images[url]
    }
    
    func cache(image: UIImage, for url: URL) {
        images[url] = image
    }
}
