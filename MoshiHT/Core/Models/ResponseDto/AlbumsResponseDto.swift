//
//  AlbumsResponseDto.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation
import UIKit

struct AlbumsSearchResponseDto: Decodable {
    var albums: SearchResponseDto
}

struct SearchResponseDto: Decodable {
    var items: [AlbumResponseDto]
}

struct AlbumResponseDto: Decodable {
    
    struct ArtistDto: Decodable {
        var name: String
    }
    
    struct SpotifyURLDto: Decodable {
        var spotify: String
    }
    
    struct ImageDto: Decodable {
        var height: Int
        var width: Int
        var url: String
    }
    
    var name: String
    var releaseDate: String
    var url: SpotifyURLDto
    var artists: [ArtistDto]
    var images: [ImageDto]
    
    func toDomain() -> Album {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var imageURL: URL?
        if let imageDto = images.first(where: { $0.height == 300 }) {
            imageURL = URL(string: imageDto.url)
        }
        
        return Album(
            name: name,
            releaseDate: dateFormatter.date(from: releaseDate),
            imageURL: imageURL,
            url: URL(string: url.spotify),
            artists: artists.map { Artist(name: $0.name) }
        )
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case releaseDate = "release_date"
        case url = "external_urls"
        case artists
        case images
    }
}
