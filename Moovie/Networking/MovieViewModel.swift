//
//  MovieViewModel.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//

import Foundation
import UIKit
import Observation

@Observable
class MovieViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([MovieMainData])
        case error(String)
    }
    
    var state: State = .idle
    var mock: Bool
    
    private let service: APIMovieService
    
    init(service: APIMovieService = ActualMovieService(), mock: Bool = true) {
        self.service = service
        self.mock = mock
    }
    
    func fetch() async {
        
        if case .loading = state {
            return
        }
        
        self.state = .loading
        
        var loadedMovieInfo: [MovieMainData] = []
        
        do {
            
            if mock == false {
                
                let configuration = try await service.fetchImageConfiguration()
                
                let movies = try await service.fetchMovieMainInfo()
                
                try await withThrowingTaskGroup(of: MovieMainData.self) { group in
                    
                    for movie in movies {
                        group.addTask {
                            try await self.fetchMovieMainData(for: movie, using: configuration)
                        }
                    }
                    
                    for try await movieInfo in group {
                        loadedMovieInfo.append(movieInfo)
                    }
                }
                
                self.state = .loaded(loadedMovieInfo)
                
            } else {
                
                let movies = try await service.fetchMovieMainInfo()
                
                for movie in movies {
                    if movie.title == "Человек-паук: Новый день" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "spiderManPoster"),
                            backdropImage: UIImage(named: "spiderManBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                    else if movie.title == "Обитель зла" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "residentEvilPoster"),
                            backdropImage: UIImage(named: "residentEvilBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                    else if movie.title == "Одиссея" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "odysseyPoster"),
                            backdropImage: UIImage(named: "odysseyBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                    else if movie.title == "Курьер" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "runnerPoster"),
                            backdropImage: UIImage(named: "runnerBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                    else if movie.title == "Хитрый койот" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "coyotePoster"),
                            backdropImage: UIImage(named: "coyoteBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                    else if movie.title == "Операция «Возмездие»" {
                        let temp = MovieMainData(
                            movie: movie,
                            posterImage: UIImage(named: "fixPoster"),
                            backdropImage: UIImage(named: "fixBackdrop")
                        )
                        
                        loadedMovieInfo.append(temp)
                    }
                }
                
                self.state = .loaded(loadedMovieInfo)
            }
            
        } catch let error as APIError{
            self.state = .error(error.errorDescription ?? "Неизвестная ошибка")
        } catch {
            self.state = .error("Неизвестная ошибка")
        }
    }
    
    func fetchMovieMainData(for movie: Movie, using configuration: ImageConfiguration) async throws -> MovieMainData {
        
        let posterURL = configuration.baseURL + PosterSizes.originalRes.description + movie.posterPath
        let backdropURL = configuration.baseURL + BackdropSizes.originalRes.description + movie.backdropPath
        
        async let posterTask = loadImage(from: posterURL)
        async let backdropTask = loadImage(from: backdropURL)
        
        let (poster, backdrop) = await(
            posterTask,
            backdropTask
        )
        
        return MovieMainData(
            movie: movie,
            posterImage: poster,
            backdropImage: backdrop
        )
        
    }
    
    func loadImage(from URLString: String?) async -> UIImage? {
        guard let URLString = URLString, !URLString.isEmpty else {
            return nil
        }
        
        do {
            return try await service.fetchImage(from: URLString)
        } catch {
            return nil
        }
    }
}

import Playgrounds
#Playground {
    let service = MockMovieService()
    let vm = MovieViewModel(service: MockMovieService(), mock: true)
    await vm.fetch()
    
    switch vm.state {
    case .idle:
        print("idle")
    case .loading:
        print("loading")
    case .loaded(let movieMainInfo):
        for movieInfo in movieMainInfo {
            print(movieInfo.movie.title)
        }
    case .error(let error):
        print(error)
    }
}
