//
//  DataConfiguration.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 10/10/2026.
//

import Foundation

struct DataConfiguration: Codable {
    let imageConfiguration: ImageConfiguration
    
    enum CodingKeys: String, CodingKey {
        case imageConfiguration = "images"
    }
}

struct ImageConfiguration: Codable {
    let baseURL: String
//    let backdropSizes: [String]
//    let postersSizes: [String]
//    let profileSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "secure_base_url"
//        case backdropSizes = "backdrop_sizes"
//        case postersSizes = "poster_sizes"
//        case profileSizes = "profile_sizes"
    }
}

struct ImageStringInfo: Identifiable, Equatable {
    let id: Int
    
    let posterString: String
    let backdropString: String
}

enum ImageGetURL: String, CustomStringConvertible {
    case baseURL = "http://image.tmdb.org/t/p/"
    case secureURL = "https://image.tmdb.org/t/p/"
    
    var description: String {
        self.rawValue
    }
}

enum PosterSizes: String, CustomStringConvertible {
    case wide92Pixels = "w92"
    case wide154Pixels = "w154"
    case wide185Pixels = "w185"
    case wide342Pizels = "w342"
    case wide500Pixels = "w500"
    case wide780Pixels = "w780"
    case originalRes = "original"
    
    var description: String {
        self.rawValue
    }
}

enum BackdropSizes: String, CustomStringConvertible {
    case wide300Pixels = "w300"
    case wide780Pixels = "w780"
    case wide1280Pixels = "w1280"
    case originalRes = "original"
    
    var description: String {
        self.rawValue
    }
}

enum ProfileSizes: String, CustomStringConvertible {
    case wide45Pixels = "w45"
    case wide185Pixels = "w185"
    case wide632Pixels = "h632"
    case originalSize = "original"
    
    var description: String {
        self.rawValue
    }
    
}
