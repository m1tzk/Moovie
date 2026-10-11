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
            case .loaded(let movies):
                List(movies) { movie in
                    NavigationLink(value: movie) {
                        Text(movie.movie.title)
                    }
                }
                .navigationDestination(for: MovieMainData.self) { movie in
                    MovieDetailView(movieInfo: movie)
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
    
    @State @Previewable var movieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
    
    MovieListView(movieViewModel: movieViewModel)
}
