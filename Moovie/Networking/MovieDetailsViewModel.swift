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
    
    enum State {
        case idle
        case loading
        case loaded(MovieScreenData)
        case error(String)
    }
    
    var state: State = .idle
    
    private let service: APIMovieService
    
    init(service: APIMovieService = ActualMovieService()) {
        self.service = service
    }
    
    func fetch(for movieInfo: MovieMainData) async {
        
        if case .loading = state {
            return
        }
        
        state = .loading
        
        do {
            
            let configuration = try await service.fetchImageConfiguration()
            
            let movieData = try await fetchMovieScreenData(with: movieInfo, using: configuration)
            
            state = .loaded(movieData)
        
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Неизвестная ошибка")
        } catch {
            self.state = .error("Неизвестная ошибка")
        }
    }
    
    func fetchMovieScreenData(with movieInfo: MovieMainData, using configuration: ImageConfiguration) async throws -> MovieScreenData {
        
        // параллельные запросы для credits и details
        async let detailsTask = service.fetchMovieDetails(for: movieInfo.movie)
        async let creditsTask = service.fetchMovieCredits(for: movieInfo.movie)
        
        // забираем результаты
        
        let (details, credits) = try await (
            detailsTask,
            creditsTask
        )
        
        // параллельная загрузка всех фотографий
        
        async let castTask = fetchCastImages(for: Array(credits.cast.prefix(5)), using: configuration)
        async let crewTask = fetchCrewImages(for: Array(credits.crew.prefix(5)), using: configuration)
        
        // забираем результаты
        
        let (cast, crew) = await (
            castTask,
            crewTask
        )
        
        return MovieScreenData(
            movieInfo: movieInfo,
            movieDetails: details,
            movieCredits: credits,
            cast: cast,
            crew: crew
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
    
    func fetchCastImages(for cast: [MovieCast], using configuration: ImageConfiguration) async -> [CastPersonData] {
        
        await withTaskGroup(of: (Int, CastPersonData).self) { group in
            for (index, castPerson) in cast.enumerated() {
                
                group.addTask {
                    let imageURL: String?
                    
                    if let path = await castPerson.getProfilePictureString(using: configuration, with: ProfileSizes.originalSize) {
                        imageURL = path
                    } else {
                        imageURL = nil
                    }
                    
                    let image = await self.loadImage(from: imageURL)
                    
                    return (
                        index,
                        CastPersonData(
                            actorPersonData: castPerson,
                            actorPersonImage: image
                        )
                    )
                    
                }
            }
            
            var fetchResults: [Int : CastPersonData] = [:]
            
            for await (index, castPresonData) in group {
                fetchResults[index] = castPresonData
            }
            
            return cast.indices.compactMap { index in
                fetchResults[index]
            }
        }
    }
    
    func fetchCrewImages(for crew: [MovieCrew], using configuration: ImageConfiguration) async -> [CrewPersonData] {
        
        await withTaskGroup(of: (Int, CrewPersonData).self) { group in
            for (index, crewPerson) in crew.enumerated() {
                
                group.addTask {
                    let imageURL: String?
                    
                    if let path = await crewPerson.getProfilePictureString(using: configuration, with: ProfileSizes.originalSize) {
                        imageURL = path
                    } else {
                        imageURL = nil
                    }
                    
                    let image = await self.loadImage(from: imageURL)
                    
                    return (
                        index,
                        CrewPersonData(
                            crewPersonData: crewPerson,
                            crewPersonImage: image
                        )
                    )
                    
                }
            }
            
            var fetchResults: [Int : CrewPersonData] = [:]
            
            for await (index, crewPresonData) in group {
                fetchResults[index] = crewPresonData
            }
            
            return crew.indices.compactMap { index in
                fetchResults[index]
            }
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
//    let viewModel = MovieDetailsViewModel(service: service)
//    
//    let movie = MockMovieService().fetchMovies().first!
//    
//    await viewModel.fetch(for: movie)
//    
//    print("Метод fetch завершился")
//    
//    switch viewModel.state {
//    case .idle:
//        print("idle")
//    case .loading:
//        print("loading")
//    case .loaded(let movieScreenData):
//        print(movieScreenData.movie.title)
//    case .error(let error):
//        print(error)
//    }
//}
