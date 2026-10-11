//
//  APIMovieService.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation

protocol APIMovieService {
    func fetchMovieMainInfo() async throws -> [Movie]
    func fetchMovieDetails(for movies: [Movie]) async throws -> [MovieDetails]
//    func fetchImageConfiguration() async throws -> ImageConfiguration
    func fetchMovieCredits(for movies: [Movie]) async throws -> [MovieCredits]
//    func fetchFilmImageInfo(for movies: [Movie]) async throws -> [MovieImagesDataContainer]
}
