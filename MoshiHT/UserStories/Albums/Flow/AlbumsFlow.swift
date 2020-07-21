//
//  AlbumsFlow.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

final class AlbumsFlow {
    
    private weak var navigationController: UINavigationController?
    private let screenProvider: AlbumsScreenProvider
    
    init(
        navigationController: UINavigationController,
        screenProvider: AlbumsScreenProvider
    ) {
        self.navigationController = navigationController
        self.screenProvider = screenProvider
    }
    
    convenience init(navigationController: UINavigationController) {
        self.init(
            navigationController: navigationController,
            screenProvider: AlbumsScreenProvider()
        )
    }
    
    func start() {
        showAlbumsListScreen()
    }
    
}

private extension AlbumsFlow {
    
    func showAlbumsListScreen() {
        guard let navigationController = navigationController else {
            assertionFailure("Navigation controller should not be nil")
            return
        }

        let controller = screenProvider.makeAlbumsListScreen { album in
            self.showAlbumDetailsScreen(album: album)
        }
        
        navigationController.viewControllers = [controller]
    }
    
    func showAlbumDetailsScreen(album: Album) {
        guard let navigationController = navigationController else {
            assertionFailure("Navigation controller should not be nil")
            return
        }

        let controller = screenProvider.makeAlbumDetailsScreen(album: album)
        navigationController.pushViewController(controller, animated: true)
    }
    
}


