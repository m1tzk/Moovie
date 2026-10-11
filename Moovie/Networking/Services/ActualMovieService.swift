//
//  ActualMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation

struct ActualMovieService: APIMovieService {
    func fetchMovieMainInfo() async throws -> [Movie] {
        
        var partialArrayOfMovies: [MovieQueryPage] = []
        
        for _ in 0...1 {
            let randomPageValue = Int.random(in: 1...30)
            
            guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie") else {
                throw APIError.invalidURL
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "language", value: "ru-RU"),
                URLQueryItem(name: "page", value: "\(randomPageValue)"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
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
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                
                partialArrayOfMovies.append(try JSONDecoder().decode(MovieQueryPage.self, from: data))
                
            } catch let error as DecodingError {
                throw APIError.decodingError(error)
            } catch let error as URLError {
                throw APIError.networkError(error)
            }
        }
        
        let movies = partialArrayOfMovies.flatMap { $0.contents }
        return movies
    }
    
    func fetchMovieDetails(for movies: [Movie] ) async throws -> [MovieDetails] {
        
        var movieDetails: [MovieDetails] = []
        
        for movie in movies {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)") else {
                throw APIError.invalidURL
            }
            
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
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                
                movieDetails.append(try JSONDecoder().decode(MovieDetails.self, from: data))
                
            } catch let error as DecodingError {
                throw APIError.decodingError(error)
            } catch let error as URLError {
                throw APIError.networkError(error)
            }
        }
        
        return movieDetails
    }
    
//    func fetchFilmImageInfo(for movies: [Movie]) async throws -> [MovieImagesDataContainer] {
//        var movieImagesDataContainers: [MovieImagesDataContainer] = []
//        
//        for movie in movies {
//            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/images") else {
//                throw APIError.invalidURL
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.timeoutInterval = 10
//            request.allHTTPHeaderFields = [
//                "accept": "application/json",
//                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YmU5MWFlOTU0YWZlYTkzMzE3ZDdjOGFhZmYwODRiZCIsIm5iZiI6MTc5MTE5NzAwOS4wNjMsInN1YiI6IjZhYzM3ZjUxZTI0ZDdhMDAzNDQ1NTg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kKMX5F3y3shNJFjWL07lsqXBoUM9ijwTC9wjT7pAbKU"
//            ]
//            
//            do {
//                let (data, response) = try await URLSession.shared.data(for: request)
//                
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    throw APIError.invalidResponse
//                }
//                
//                movieImagesDataContainers.append(try JSONDecoder().decode(MovieImagesDataContainer.self, from: data))
//                
//                //                let movieBackdrops = Array(movieImagesDataContainer.backdrops ?? []).prefix(10)
//                //
//                //                let posters = Array(movieImagesDataContainer.posters ?? []).prefix(20)
//                
//            } catch let error as DecodingError {
//                throw APIError.decodingError(error)
//            } catch let error as URLError {
//                throw APIError.networkError(error)
//            }
//        }
//        return movieImagesDataContainers
//    }
    
    func fetchImageConfiguration() async throws -> ImageConfiguration {
        
        var imageConfiguration: ImageConfiguration
        
        guard let url = URL(string: "https://api.themoviedb.org/3/configuration") else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0YmU5MWFlOTU0YWZlYTkzMzE3ZDdjOGFhZmYwODRiZCIsIm5iZiI6MTc5MTE5NzAwOS4wNjMsInN1YiI6IjZhYzM3ZjUxZTI0ZDdhMDAzNDQ1NTg1YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kKMX5F3y3shNJFjWL07lsqXBoUM9ijwTC9wjT7pAbKU"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            let temp = try JSONDecoder().decode(DataConfiguration.self, from: data)
            
            imageConfiguration = temp.imageConfiguration
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
        return imageConfiguration
    }
    
    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits] {
        
        var movieCredits: [MovieCredits] = []
        
        for movie in movies {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits") else {
                throw APIError.invalidURL
            }
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
                "Authorization": "Bearer ••••"
            ]
            
            do {
                
                let (data, response) = try await URLSession.shared.data(for: request)
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                
                movieCredits.append(try JSONDecoder().decode(MovieCredits.self, from: data))
                
            } catch let error as DecodingError {
                throw APIError.decodingError(error)
            } catch let error as URLError {
                throw APIError.networkError(error)
            }
            
        }
        return movieCredits
    }
}
