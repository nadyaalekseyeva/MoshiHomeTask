//
//  AlbumsScreenProvider.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

protocol AlbumsScreenProviderProtocol {
    func makeAlbumsListScreen(selectionAction: @escaping (Album) -> Void) -> UIViewController
    func makeAlbumDetailsScreen(album: Album) -> UIViewController
}

struct AlbumsScreenProvider: AlbumsScreenProviderProtocol {
    
    func makeAlbumsListScreen(selectionAction: @escaping (Album) -> Void) -> UIViewController {
        let presenter = AlbumsListPresenter(selectionAction: selectionAction)
        return AlbumsListViewController(presenter: presenter)
    }
    
    func makeAlbumDetailsScreen(album: Album) -> UIViewController {
        let detailsPresenter = AlbumDetailsPresenter(album: album)
        return AlbumDetailsViewController(presenter: detailsPresenter)
    }
    
}
