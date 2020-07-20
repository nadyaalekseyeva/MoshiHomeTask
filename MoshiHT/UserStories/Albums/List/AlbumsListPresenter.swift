//
//  AlbumsListPresenter.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

final class AlbumsListPresenter {
    
    private(set) var albums = [Album]()
    
    private let apiService: AlbumsApiServiceProtocol

    init(apiService: AlbumsApiServiceProtocol) {
        self.apiService = apiService
    }
    
    convenience init() {
        self.init(apiService: AlbumsApiService())
    }
    
    func updateAlbums(completion: @escaping () -> Void) {
        apiService.fetchAlbums { result in
            switch result {
            case .success(let albums):
                self.albums = albums.map { $0.toDomain() }
                DispatchQueue.main.async {
                    completion()
                }
            case .failure: break
            }
        }
    }

}
