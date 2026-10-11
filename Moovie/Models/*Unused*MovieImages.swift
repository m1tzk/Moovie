//
//  MovieImages.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 10/10/2026.
//

//MARK: Неиспользуемая расширенная структура получения информации об изображениях

import Foundation

struct MovieImagesDataContainer: Codable, Identifiable, Equatable {
    let id: Int
    let backdrops: [MovieBackdropsData]?
    let posters: [MoviePostersData]?
}

struct MovieBackdropsData: Codable, Identifiable, Equatable {
    var id: String { filePath }
    
    let filePath: String
    let height: Int
    let width: Int
    let relevance: Double
    
    enum CodingKeys: String, CodingKey {
        case height, width
        
        case filePath = "file_path"
        case relevance = "vote_average"
    }
}

struct MoviePostersData: Codable, Identifiable, Equatable {
    var id: String { filePath }
    
    let filePath: String
    let height: Int
    let width: Int
    let relevance: Double
    
    enum CodingKeys: String, CodingKey {
        case height, width
        
        case filePath = "file_path"
        case relevance = "vote_average"
    }
}


import Playgrounds
#Playground {
    if let url = URL(string: "https://api.themoviedb.org/3/movie/969681/images") {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer ***REMOVED***"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let movieImagesDataContainer = try JSONDecoder().decode(MovieImagesDataContainer.self, from: data)
            
            let movieBackdrops = Array(movieImagesDataContainer.backdrops ?? []).prefix(10)
            
            let posters = Array(movieImagesDataContainer.posters ?? []).prefix(20)
            
        } catch {
            print(error)
        }
    }
}
