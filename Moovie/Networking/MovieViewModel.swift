//
//  MovieViewModel.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation
import Observation

@Observable
class MovieViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Movie]/*, [MovieDetails], [MovieCredits]*/)
        case error(String)
    }
    
    var state: State = .idle
    var movies: [Movie] = []
    
    private let service: APIMovieService
    
    init(service: APIMovieService = ActualMovieService()) {
        self.service = service
    }
    
    func fetch() async {
        guard state == .idle else { return }
        
        self.state = .loading
        
        do {
            movies = try await service.fetchMovieMainInfo()
            
//            let movieDetails = try await service.fetchMovieDetails(for: movies)
//            
//            let movieCredits = try await service.fetchMovieCredits(for: movies)
            
            self.state = .loaded(movies/*, movieDetails, movieCredits*/)
        } catch let error as APIError{
            self.state = .error(error.errorDescription ?? "Неизвестная ошибка")
        } catch {
            self.state = .error("Неизвестная ошибка")
        }
    }
    
//    func getMovieImageStrings(using configuration: ImageConfiguration, for moviesDetails: [MovieDetails]) -> [ImageStringInfo] {
//        
//        var imageStringInfo: [ImageStringInfo] = []
//        
//        for movieDetail in moviesDetails {
//            let tempImageStringInfo = ImageStringInfo(
//                id: movieDetail.id,
//                posterString: configuration.baseURL + movieDetail.posterPath,
//                backdropString: configuration.baseURL + movieDetail.backdropPath
//            )
//            
//            imageStringInfo.append(tempImageStringInfo)
//        }
//        return imageStringInfo
//    }
    
}
