//
//  Movie.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 05/10/2026.
//

import Foundation

struct MovieQueryPage: Codable, Identifiable, Equatable {
    let id: Int
    let contents: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case id = "page"
        case contents = "results"
    }
}

struct Movie: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let description: String?
    let popularity: Double
    let posterPath: String?
    let backdropPath: String?  
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, popularity
        
        case description = "overview"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}

//var randomInt = Int.random(in: 0...100)
//var movieMainInfo: [MovieQueryPage] = []
//var movies: [Movie] = []

import Playgrounds
#Playground {
    
//    for _ in 0...10 {
//        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie") {
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//            let queryItems: [URLQueryItem] = [
//                URLQueryItem(name: "language", value: "ru-RU"),
//                URLQueryItem(name: "page", value: "\(randomInt)"),
//                URLQueryItem(name: "sort_by", value: "popularity.desc"),
//            ]
//            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//            
//            var request = URLRequest(url: components.url!)
//            request.httpMethod = "GET"
//            request.timeoutInterval = 10
//            request.allHTTPHeaderFields = [
//                "accept": "application/json",
//                "Authorization": "Bearer ***REMOVED***"
//            ]
//            
//            do {
//                let (data, response) = try await URLSession.shared.data(for: request)
//                
//                movieMainInfo.append(try JSONDecoder().decode(MovieQueryPage.self, from: data))
//                
//            } catch {
//                print(error)
//            }
//        }
//    }
//    
//    movies = movieMainInfo.flatMap { $0.contents }
    
//    let url = URL(string: "https://api.themoviedb.org/3/search/movie")!
//    
//    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//    let queryItems: [URLQueryItem] = [
//        URLQueryItem(name: "query", value: "Человек"),
//        URLQueryItem(name: "language", value: "ru-RU"),
//        URLQueryItem(name: "page", value: "1"),
//    ]
//    components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
//    
//    var request = URLRequest(url: components.url!)
//    request.httpMethod = "GET"
//    request.timeoutInterval = 10
//    request.allHTTPHeaderFields = [
//        "accept": "application/json",
//        "Authorization": "Bearer ***REMOVED***"
//    ]
//    
//    
//    let (data, response) = try await URLSession.shared.data(for: request)
//
//    let result = try JSONDecoder().decode(MovieQueryPage.self, from: data)

}

