//
//  AlbumsListPresenter.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

final class AlbumsListPresenter {
    
    private let apiService: AlbumsApiServiceProtocol
    
    init(apiService: AlbumsApiServiceProtocol) {
        self.apiService = apiService
    }
    
    convenience init() {
        self.init(apiService: AlbumsApiService())
    }
    
    let albums = Album.testAlbums
    
    func fetch() {
        apiService.fetchAlbums { result in
            switch result {
            case .success(let albums):
                print(albums.count)
            case .failure(let error):
                print("error")
            }
        }
    }

}
