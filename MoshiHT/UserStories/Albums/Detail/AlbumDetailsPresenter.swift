//
//  AlbumDetailsPresenter.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 21/07/2020.
//

import UIKit

final class AlbumDetailsPresenter {
    
    let album: Album
    private let imagesStore: ImagesStore
    
    init(album: Album, imagesStore: ImagesStore) {
        self.album = album
        self.imagesStore = imagesStore
    }
    
    convenience init(album: Album) {
        self.init(album: album, imagesStore: InMemoryImagesStore.shared)
    }
    
    func getImage() -> UIImage? {
        guard let url = album.imageURL else { return nil }
        return self.imagesStore.getImage(url: url)
    }
    
}
