//
//  AlbumsListInteractor.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import UIKit

protocol AlbumsListInteractorProtocol {
    func fetchAlbums(completion: @escaping (Result<[Album], NetworkError>) -> Void)
    func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class AlbumsListInteractor: AlbumsListInteractorProtocol {
    
    private let apiService: AlbumsApiServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    private let imagesStore: ImagesStore
    
    init(
        apiService: AlbumsApiServiceProtocol,
        imageLoader: ImageLoaderProtocol,
        imagesStore: ImagesStore
    ) {
        self.apiService = apiService
        self.imageLoader = imageLoader
        self.imagesStore = imagesStore
    }
    
    convenience init() {
        self.init(apiService: AlbumsApiService(),
                  imageLoader: ImageLoader(),
                  imagesStore: InMemoryImagesStore.shared)
    }
    
    func fetchAlbums(completion: @escaping (Result<[Album], NetworkError>) -> Void) {
        apiService.searchAlbums { result in
            switch result {
            case .success(let dtos):
                let albums = dtos.map { $0.toDomain() }
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        if let image = self.imagesStore.getImage(url: url) {
            completion(.success(image))
        } else {
            self.loadAndCacheImage(url: url, completion: completion)
        }
    }
    
    private func loadAndCacheImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        imageLoader.loadImage(url: url) { result in
            switch result {
            case .success(let image):
                self.imagesStore.cache(image: image, for: url)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
