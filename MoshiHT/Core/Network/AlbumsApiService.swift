//
//  AlbumsApiService.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

protocol AlbumsApiServiceProtocol {
    func searchAlbums(completion: @escaping (Result<[AlbumResponseDto], NetworkError>) -> Void)
}

final class AlbumsApiService: AlbumsApiServiceProtocol {
    
    private let accessToken = "Put your token here"
    
    func searchAlbums(completion: @escaping (Result<[AlbumResponseDto], NetworkError>) -> Void) {
        let baseURL = "https://api.spotify.com/v1/search"
        guard let url = URL(string: "\(baseURL)?q=jazz&type=album") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Error parsing response")
                return
            }
            
            switch httpResponse.statusCode {
            case (200...209):
                let decoder = JSONDecoder()
                guard let data = data,
                      let albums = try? decoder.decode(AlbumsSearchResponseDto.self, from: data)
                else {
                    completion(.failure(.parsingError))
                    return
                }
                completion(.success(albums.albums.items))
            case 401:
                completion(.failure(.unauthorized))
            default: completion(.failure(.unknown))
            }
        }
        task.resume()
        
    }
    
}
