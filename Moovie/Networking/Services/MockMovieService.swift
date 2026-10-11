//
//  MockMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation
import UIKit

struct MockMovieService: APIMovieService {
    
    private struct SampleData: Decodable {
        let movies: [Movie]
        
        let movieDetails: [MovieDetails]
        
        let movieCredits: [MovieCredits]
    }
    
    
    private func loadSampleData() throws -> SampleData {
        
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: ".json") else {
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
            
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }

    
    //MARK: Protocol conformances
    func fetchMovieMainInfo() async throws -> [Movie] {
        let data = try loadSampleData()
        return data.movies
    }
    
    func fetchMovieDetails(for movie: Movie) async throws -> MovieDetails {
        let data = try loadSampleData()
        return data.movieDetails.first!
    }
    
    
    func fetchMovieCredits(for movie: Movie) async throws -> MovieCredits {
        let data = try loadSampleData()
        return data.movieCredits.first!
    }
    
    func fetchImageConfiguration() async throws -> ImageConfiguration {
        let imageConfiguration = ImageConfiguration(baseURL: "https://image.tmdb.org/t/p/")
        return imageConfiguration
    }
    
    func fetchImage(from URLString: String) async throws -> UIImage {
        return UIImage(named: "spiderManPosterSample.jpg")!
    }
    
    //MARK: MovieDetailsViewModel testing/playground
    func fetchMovies() -> [Movie] {
        let data = try! loadSampleData()
        return data.movies
    }
    
    func fetchMovieImageConfiguration() -> ImageConfiguration {
        let imageConfiguration = ImageConfiguration(baseURL: "https://image.tmdb.org/t/p/")
        return imageConfiguration
    }
    
    //MARK: MovieDetailView preview func
    func fetchMovie() -> Movie {
        let data = try! loadSampleData()
        return data.movies.first!
    }
    
    //MARK: Reserve methods
    //    func fetchMovieDetails(for movies: [Movie]) async throws -> [MovieDetails] {
    //        let data = try loadSampleData()
    //        return data.movieDetails
    //    }
    //
    //    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits] {
    //        let data = try loadSampleData()
    //        return data.movieCredits
    //    }
    
}
