//
//  NetworkError.swift
//  MoshiHT
//
//  Created by Nadzeya Aliakseyeva on 20/07/2020.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case badURL
    case unknown
    case parsingError
}
