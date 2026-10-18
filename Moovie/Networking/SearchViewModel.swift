//
//  SearchViewModel.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 18/10/2026.
//

import Foundation
import Observation
import UIKit

@Observable
class SearchViewModel {
    
    var state: LoadingState<[MovieMainData]> = .idle
    var mock: Bool
    
    private var currentSearch: String = ""
    
    private let service: APIMovieService
    
    init(service: APIMovieService = ActualMovieService(), mock: Bool = false) {
        self.service = service
        self.mock = mock 
    }
    
    func fetch(for searchLine: String) async {
        
        self.currentSearch = searchLine
        
        guard !searchLine.isEmpty else {
            self.state = .idle
            return
        }
        
        self.state = .loading
        
        var loadedMovieInfo: [MovieMainData] = []
        
        do {
            
            try await Task.sleep(for: .milliseconds(1000))
            try Task.checkCancellation()
            
            if mock == false {
                
                let configuration = try await service.fetchImageConfiguration()
                
                let movies = try await service.searchFilms(for: searchLine)
                
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
                
                guard currentSearch == searchLine else {
                    return
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
            
        } catch {
            setError(error, for: searchLine)
        }
//        } catch let error as APIError{
//            self.state = .error(error.errorDescription ?? "Неизвестная ошибка")
//        } catch let error as CancellationError {
//            if currentSearch == searchLine {
//                self.state = .idle
//            }
//        } catch {
//            self.state = .error("Неизвестная ошибка")
//        }
    }
    
    private func fetchMovieMainData(for movie: Movie, using configuration: ImageConfiguration) async throws -> MovieMainData {
        
        let posterURL = configuration.baseURL + PosterSizes.originalRes.description + (movie.posterPath ?? "")
        let backdropURL = configuration.baseURL + BackdropSizes.originalRes.description + (movie.backdropPath ?? "")
        
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
    
    private func loadImage(from URLString: String?) async -> UIImage? {
        guard let URLString = URLString, !URLString.isEmpty else {
            return nil
        }
        
        do {
            return try await service.fetchImage(from: URLString)
        } catch {
            return nil
        }
    }
    
    private func setError(_ error: Error, for searchLine: String) {
        
        guard currentSearch == searchLine else { return }
        
        if let error = error as? APIError {
            self.state = .error(error.errorDescription ?? "Неизвестная ошибка")
        } else {
            self.state = .error("Неизвестная ошибка")
        }
    }
}

//import Playgrounds
//
//#Playground {
//
//    print("Запуск Playground")
//
//    let service = ActualMovieService()
//    let viewModel = SearchViewModel(service: service, mock: false)
//    
//    print("Запук метода fetch")
//
//    await viewModel.fetch(for: "Паук")
//
//    print("Метод fetch завершился")
//
//    switch viewModel.state {
//    case .idle:
//        print("idle")
//    case .loading:
//        print("loading")
//    case .loaded(let movieInfo):
//        for movie in movieInfo {
//            print(movie.movie.title)
//        }
//    case .error(let error):
//        print(error)
//    }
//}
