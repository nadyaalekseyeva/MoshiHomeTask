//
//  AlbumsScreenProvider.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

protocol AlbumsScreenProviderProtocol {
    func makeAlbumsListScreen() -> UIViewController
    func makeAlbumDetailsScreen() -> UIViewController
}

struct AlbumsScreenProvider: AlbumsScreenProviderProtocol {
    
    func makeAlbumsListScreen() -> UIViewController {
        let presenter = AlbumsListPresenter()
        return AlbumsListViewController(presenter: presenter)
    }
    
    func makeAlbumDetailsScreen() -> UIViewController {
        return UIViewController()
    }
    
}
