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
    private let selectionAction: (Album) -> Void
    
    init(
        interactor: AlbumsListInteractorProtocol,
        selectionAction: @escaping (Album) -> Void
    ) {
        self.interactor = interactor
        self.selectionAction = selectionAction
    }
    
    convenience init(selectionAction: @escaping (Album) -> Void) {
        self.init(
            interactor: AlbumsListInteractor(),
            selectionAction: selectionAction
        )
    }

    func updateAlbums(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        interactor.fetchAlbums { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    completion(.success)
                }
            case .failure:
                DispatchQueue.main.async {
                    completion(.failure(.unauthorized))
                }
            }
        }
    }
    
    func loadImage(url: URL, completion: @escaping (UIImage) -> Void) {
        interactor.getImage(url: url) { result in
            guard case .success(let image) = result else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let album = albums[indexPath.row]
        selectionAction(album)
    }

}
