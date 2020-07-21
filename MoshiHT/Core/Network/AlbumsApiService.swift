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
    
    func searchAlbums(completion: @escaping (Result<[AlbumResponseDto], NetworkError>) -> Void) {
        let baseURL = "https://api.spotify.com/v1/search"
        guard let url = URL(string: "\(baseURL)?q=jazz&type=album") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer BQCMx1BaT7huSpNLcra--sJhA84VFe3BwDvje5pR-qswfeYmwUGOWSNEXRRFUxGycL8c7b9wXR50gAcXZvjXda-z1BA-I-lolYHO1fb-K5LhH20H-s5j4zwTvXIQt6N7UWLl3QMSajl3-iCSyi5YPngZAEp70JPclmhRg6Tbr4kpad_Trw", forHTTPHeaderField: "Authorization")
        
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
