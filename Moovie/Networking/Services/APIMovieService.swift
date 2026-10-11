//
//  APIMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation
import UIKit

@MainActor
protocol APIMovieService: Sendable {
    func fetchMovieMainInfo() async throws -> [Movie]
    func fetchMovieDetails(for movie: Movie) async throws -> MovieDetails
    func fetchMovieCredits(for movie: Movie) async throws -> MovieCredits
    func fetchImageConfiguration() async throws -> ImageConfiguration
    func fetchImage(from URLString: String) async throws -> UIImage
    
//    func fetchMovieDetails(for movies: [Movie]) async throws -> [MovieDetails]
//    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits]
//    func fetchFilmImageInfo(for movies: [Movie]) async throws -> [MovieImagesDataContainer]
}
