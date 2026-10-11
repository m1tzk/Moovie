//
//  MovieDetailsViewModel.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 11/10/2026.
//

import SwiftUI
import Observation

@Observable
class MovieDetailsViewModel {
    
    var movieDetails: [MovieDetails] = []
    var movieCredits: [MovieCredits] = []
    
    private let service: APIMovieService
    
    init(service: APIMovieService = ActualMovieService()) {
        self.service = service
    }
    
    func fetch(for movie: Movie) async {
        
//        do {
//            try await withThrowingTaskGroup(of: MovieDetails.self) { group in
//                <#code#>
//            }
//            
//            
//        } catch {
//            
//        }
    }
}
