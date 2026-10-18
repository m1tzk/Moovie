//
//  ActualMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation
import UIKit

struct ActualMovieService: APIMovieService {
    
    func searchFilms(for searchLine: String) async throws -> [Movie] {
        
        var partialArrayOfMovies: MovieQueryPage
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie") else {
            throw APIError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: "\(searchLine)"),
            URLQueryItem(name: "language", value: "ru-RU"),
            URLQueryItem(name: "page", value: "1"),
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
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            partialArrayOfMovies = try JSONDecoder().decode(MovieQueryPage.self, from: data)
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
        
        let movies = partialArrayOfMovies.contents
        return movies
        
    }
    
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
                "Authorization": "Bearer ***REMOVED***"
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
    
    /* ПОЛУЧИТЬ ДЕТЕЙЛС ПО ОДНОМУ ФИЛЬМУ */
    
    func fetchMovieDetails(for movie: Movie) async throws -> MovieDetails {
        
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
            "Authorization": "Bearer ***REMOVED***"
        ]
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return (try JSONDecoder().decode(MovieDetails.self, from: data))
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    /* ПОЛУЧИТЬ КРЭДИТС ПО ОДНОМУ ФИЛЬМУ */
    
    func fetchMovieCredits(for movie: Movie) async throws -> MovieCredits {
        
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
            "Authorization": "Bearer ***REMOVED***"
        ]
        
        do {
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return (try JSONDecoder().decode(MovieCredits.self, from: data))
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
        
    }
    
    /* ПОЛУЧИТЬ ImageConfiguration ДЛЯ ФОРМИРОВАНИЯ СТРОКИ */
    
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
            "Authorization": "Bearer ***REMOVED***"
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
    
    /* ПОЛУЧИТЬ ФОТО ПО ЗАДАННОЙ ССЫЛКЕ */
    
    func fetchImage(from URLString: String) async throws -> UIImage {
        
        let image: UIImage
        
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            guard let tryImage = UIImage(data: data) else {
                throw APIError.imageConversionError
            }
            
            image = tryImage
            
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
        return image
    }
    
    
        /* ПОЛУЧИТЬ ДЕТЭЙЛЗ ПО ВСЕМ ФИЛЬМАМ */
    
//    func fetchMovieDetails(for movies: [Movie] ) async throws -> [MovieDetails] {
//
//        var movieDetails: [MovieDetails] = []
//
//        for movie in movies {
//            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)") else {
//                throw APIError.invalidURL
//            }
//
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//            let queryItems: [URLQueryItem] = [
//                URLQueryItem(name: "language", value: "ru-RU"),
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
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    throw APIError.invalidResponse
//                }
//
//                movieDetails.append(try JSONDecoder().decode(MovieDetails.self, from: data))
//
//            } catch let error as DecodingError {
//                throw APIError.decodingError(error)
//            } catch let error as URLError {
//                throw APIError.networkError(error)
//            }
//        }
//
//        return movieDetails
//    }
    
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
//                "Authorization": "Bearer ***REMOVED***"
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
    
    /*   ПОЛУЧИТЬ КРЕДИТСЫ ДЛЯ ВСЕХ ФИЛЬМОВ */
    
//    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits] {
//        
//        var movieCredits: [MovieCredits] = []
//        
//        for movie in movies {
//            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits") else {
//                throw APIError.invalidURL
//            }
//            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//            let queryItems: [URLQueryItem] = [
//                URLQueryItem(name: "language", value: "ru-RU"),
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
//                
//                let (data, response) = try await URLSession.shared.data(for: request)
//                
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    throw APIError.invalidResponse
//                }
//                
//                movieCredits.append(try JSONDecoder().decode(MovieCredits.self, from: data))
//                
//            } catch let error as DecodingError {
//                throw APIError.decodingError(error)
//            } catch let error as URLError {
//                throw APIError.networkError(error)
//            }
//            
//        }
//        return movieCredits
//    }
    
}
