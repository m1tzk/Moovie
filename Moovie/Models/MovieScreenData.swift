//
//  MovieScreenData.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 13/10/2026.
//

import Foundation
import UIKit

struct MovieScreenData: Identifiable {
    var id: Int {
        movieInfo.id
    }
    let movieInfo: MovieMainData
    let movieDetails: MovieDetails
    let movieCredits: MovieCredits
    
    let cast: [CastPersonData]
    let crew: [CrewPersonData]
}

struct CastPersonData: Identifiable {
    var id: Int {
        actorPersonData.id
    }
    
    let actorPersonData: MovieCast
    let actorPersonImage: UIImage?
}

struct CrewPersonData: Identifiable {
    var id: Int {
        crewPersonData.id
    }
    
    let crewPersonData: MovieCrew
    let crewPersonImage: UIImage?
}

struct MovieMainData: Identifiable, Hashable {
    var id: Int {
        movie.id
    }
    
    let movie: Movie
    
    let posterImage: UIImage?
    let backdropImage: UIImage?
    
    static var example: MovieMainData {
        MovieMainData(
            movie: MockMovieService().fetchMovie(),
            posterImage: UIImage(named: "spiderManPoster"),
            backdropImage: UIImage(named: "spiderManBackdrop")
        )
    }

}
