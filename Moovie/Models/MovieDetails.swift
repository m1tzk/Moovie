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
    
    func getProfilePictureString(using configuration: ImageConfiguration, with resolution: ProfileSizes) -> String? {
        
        guard let profilePicturePath = profilePicturePath else { return nil }
        
        return configuration.baseURL + resolution.description + profilePicturePath
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
    
    func getProfilePictureString(using configuration: ImageConfiguration, with resolution: ProfileSizes) -> String? {
        
        guard let profilePicturePath = profilePicturePath else { return nil }
        
        return configuration.baseURL + resolution.description + profilePicturePath
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
            "Authorization": "Bearer ***REMOVED***"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let currentMovieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
        } catch {
            print(error)
        }
    }
    
    
}
