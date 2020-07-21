//
//  AlbumsListInteractor.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import UIKit

protocol AlbumsListInteractorProtocol {
    func fetchAlbums(completion: @escaping (Result<[Album], NetworkError>) -> Void)
    func loadImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class AlbumsListInteractor: AlbumsListInteractorProtocol {
    
    private let apiService: AlbumsApiServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    
    init(
        apiService: AlbumsApiServiceProtocol,
        imageLoader: ImageLoaderProtocol
    ) {
        self.apiService = apiService
        self.imageLoader = imageLoader
    }
    
    convenience init() {
        self.init(apiService: AlbumsApiService(), imageLoader: ImageLoader())
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
    
    func loadImage(url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        imageLoader.loadImage(url: url) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
