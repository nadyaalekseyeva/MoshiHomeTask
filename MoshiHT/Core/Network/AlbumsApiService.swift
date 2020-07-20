//
//  AlbumsApiService.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

protocol AlbumsApiServiceProtocol {
    func fetchAlbums(completion: @escaping (Result<[AlbumResponseDto], NetworkError>) -> Void)
}

final class AlbumsApiService: AlbumsApiServiceProtocol {
    
    func fetchAlbums(completion: @escaping (Result<[AlbumResponseDto], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.spotify.com/v1/albums/?ids=41MnTivkwTO3UUJ8DrqEJJ,6JWc4iAiJ9FjyK0B59ABb4,6UXCm6bOO4gFlDQZV5yL37") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer BQDpVv9RuPcbUR5ZSv_hY8LPloYZSXwqQIFUahsKn_zrBvwXRFrNqPWPzBwnCTN_VOmPx-hMl0YW-X7Tgow9XncvdrqnaU93IINAFBpLQfE-Bi_7XPl45SgTPdz_3X4LSQmVctRcJWoGZWK3W83cRC3Tf9_ztiMco-sOD6cxjetp4g93Vg", forHTTPHeaderField: "Authorization")
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
                      let albums = try? decoder.decode(AlbumsResponseDto.self, from: data)
                else {
                    completion(.failure(.parsingError))
                    return
                }
                completion(.success(albums.albums))
            case 401:
                completion(.failure(.unauthorized))
            default: completion(.failure(.unknown))
            }
        }
        task.resume()
    }
    
}
