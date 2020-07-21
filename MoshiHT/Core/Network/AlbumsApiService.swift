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
        request.setValue("Bearer BQBM2lCjav90gAmphm2GhQaTE-iMTdZG3k__FhKeARLczQiTsSoRsIWM0E46_9isf6G1YJgw6nRZ3oYlg-3W0jxHDHefRo7cPCKZ2WinBdWFb2K0sqpzPqLlrwW3UEzR4LXC1qPL-y5EiA6-ySX48ScsnVJX1HF5_hQp4CdPK0z-KALH7Q", forHTTPHeaderField: "Authorization")
        
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
