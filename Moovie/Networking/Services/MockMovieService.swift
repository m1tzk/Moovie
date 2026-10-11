//
//  MockMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation

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

    
    func fetchMovieMainInfo() async throws -> [Movie] {
        let data = try loadSampleData()
        return data.movies
    }
    
    func fetchMovieDetails(for movies: [Movie]) async throws -> [MovieDetails] {
        let data = try loadSampleData()
        return data.movieDetails
    }
    
    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits] {
        let data = try loadSampleData()
        return data.movieCredits
    }
    
}
