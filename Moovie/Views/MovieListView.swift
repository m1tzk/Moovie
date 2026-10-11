//
//  MovieListView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.
//
import SwiftUI

struct MovieListView: View {
    
    /*@State private */var movieViewModel: MovieViewModel = MovieViewModel()
    
    var body: some View {
        
        NavigationStack {
            switch movieViewModel.state {
            case .idle:
                Text("Фильмов пока нет.")
            case .loading:
                ProgressView {
                    Text("Идет загрузка...")
                }
            case .loaded(let movies/*, let movieDetails, let movieCredits*/):
                List(movies) { movie in
                    Text(movie.title)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.primary)
            }
        }
        .task {
            await movieViewModel.fetch()
        }
    }
}

#Preview {
    
    @State @Previewable var movieViewModel = MovieViewModel(service: MockMovieService())
    
    MovieListView(movieViewModel: movieViewModel)
}
