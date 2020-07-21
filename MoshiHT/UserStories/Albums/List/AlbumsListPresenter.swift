//
//  AlbumsListPresenter.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation
import UIKit

final class AlbumsListPresenter {
    
    private(set) var albums = [Album]()
    
    private let interactor: AlbumsListInteractorProtocol
    
    init(interactor: AlbumsListInteractorProtocol) {
        self.interactor = interactor
    }
    
    convenience init() {
        self.init(interactor: AlbumsListInteractor())
    }
    
    
    func updateAlbums(completion: @escaping () -> Void) {
        interactor.fetchAlbums { result in
            guard case .success(let albums) = result else { return }
            self.albums = albums
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func loadImage(url: URL, completion: @escaping (UIImage) -> Void) {
        interactor.loadImage(url: url) { result in
            guard case .success(let image) = result else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

}
