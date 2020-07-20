//
//  AlbumsResponseDto.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation
import UIKit

struct AlbumsResponseDto: Decodable {
    var albums: [AlbumResponseDto]
}

struct AlbumResponseDto: Decodable {
    
    struct ArtistDto: Decodable {
        var name: String
    }
    
    struct SpotifyURLDto: Decodable {
        var spotify: String
    }
    
    var name: String
    var releaseDate: String
    var url: SpotifyURLDto
    var artists: [ArtistDto]
    // NA: add images
    
    func toDomain() -> Album {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return Album(
            name: name,
            releaseDate: dateFormatter.date(from: releaseDate),
            image: UIImage(named: "TestCover"), // NA: change
            url: URL(string: url.spotify),
            artists: artists.map { Artist(name: $0.name) }
        )
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case releaseDate = "release_date"
        case url = "external_urls"
        case artists
    }
}
