//
//  MovieDetails.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 05/10/2026.
//
import Foundation

struct MovieDetails: Codable, Identifiable, Equatable {
    let id: Int
    let isAdult: Bool
    let budget: Int
    let countries: [String]
    let releaseDate: String?
    let revenue: Int
    let runtime: Int?
    let status: String
    let voteAvgRating: Double
    let voteCount: Int
    let posterPath: String
    let backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, budget, revenue, runtime, status
        
        case isAdult = "adult"
        case countries = "origin_country"
        case releaseDate = "release_date"
        case voteAvgRating = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct MovieCredits: Codable, Identifiable, Equatable {
    let id: Int
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Codable, Equatable {
    let id: Int
    
    let gender: Int
    let name: String
    let nativeName: String
    let role: String
    let profilePicturePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, gender, name
        
        case nativeName = "original_name"
        case role = "character"
        case profilePicturePath = "profile_path"
    }
    
    func getProfilePictureString(using configuration: ImageConfiguration) -> String {
        
        guard let profilePicturePath = profilePicturePath else { return "" }
        
        return configuration.baseURL + profilePicturePath
    }
}

struct MovieCrew: Codable, Equatable {
    let id: Int
    
    let gender: Int
    let name: String
    let nativeName: String
    let job: String
    let profilePicturePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, gender, name, job
        
        case nativeName = "original_name"
        case profilePicturePath = "profile_path"
    }
    
    func getProfilePictureString(using configuration: ImageConfiguration) -> String {
        
        guard let profilePicturePath = profilePicturePath else { return "" }
        
        return configuration.baseURL + profilePicturePath
    }
}



import Playgrounds

#Playground {
    if let url = URL(string: "https://api.themoviedb.org/3/movie/\(969681)") {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "ru-RU"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YmU5MWFlOTU0YWZlYTkzMzE3ZDdjOGFhZmYwODRiZCIsIm5iZiI6MTc5MTE5NzAwOS4wNjMsInN1YiI6IjZhYzM3ZjUxZTI0ZDdhMDAzNDQ1NTg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kKMX5F3y3shNJFjWL07lsqXBoUM9ijwTC9wjT7pAbKU"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let currentMovieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
        } catch {
            print(error)
        }
    }
}
