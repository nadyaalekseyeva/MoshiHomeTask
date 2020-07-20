//
//  Album.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import UIKit

struct Album {
    var name: String
    var releaseDate: Date
    var image: UIImage
    var url: String
}

// NA: Test data, remove
extension Album {
    
    static var testAlbums: [Album] = {
        let names = ["The Queen Is Dead", "Revolver", "Doolittle", "The White Album", "Nevermind", "Low", "It Takes A Nation Of Millions To Hold Us Back", "My Beautiful Dark Twisted Fantasy", "Parklife", "Pet Sounds", "Modern Life Is Rubbish", "Abbey Road", "In Utero", "Never Mind The Bollocks", "Daydream Nation", "Rumours", "Let It Bleed", "Station To Station", "Remain In Light", "Surfer Rosa"]
        return names.map {
            Album(
                name: $0,
                releaseDate: Date(),
                image: UIImage(named: "TestCover")!,
                url: ""
            )
        }
    }()
    
}
