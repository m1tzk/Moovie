//
//  MovieListView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//
import SwiftUI

struct MovieListView: View {
    
    //    /*@State private */var movieViewModel: MovieViewModel = MovieViewModel()
    
    var movies: [MovieMainData]
    
    var body: some View {
        
        List(movies) { movie in
            NavigationLink(value: movie) {
                HStack {
                    MovieImageView(image: movie.posterImage!)
                        .frame(width: 100, height: 150)
                    Text(movie.movie.title)
                }
            }
        }
        .navigationDestination(for: MovieMainData.self) { movie in
            MovieDetailView(movieInfo: movie)
        }
        
    }
}

//#Preview {
//    
//    @State @Previewable var movieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
//    
//    MovieListView(movieViewModel: movieViewModel)
//}
