//
//  AlbumsResponseDto.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

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
    
    private enum CodingKeys: String, CodingKey {
        case name
        case releaseDate = "release_date"
        case url = "external_urls"
        case artists
    }
}
