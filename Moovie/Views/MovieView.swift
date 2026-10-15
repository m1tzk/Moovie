//
//  MovieView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 15/10/2026.
//

import SwiftUI

struct MovieView: View {
    
    let movieViewModel: MovieViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch movieViewModel.state {
                case .idle:
                    Text("Фильмов пока нет.")
                case .loading:
                    ProgressView {
                        Text("Идет загрузка...")
                    }
                case .loaded(let movies):
                    MovieListView(movies: movies)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.primary)
                }
            }
            .navigationTitle("Фильмы")
        }
        .task {
            await movieViewModel.fetch()
        }
    }
}

#Preview {
    MovieView(movieViewModel: MovieViewModel(service: MockMovieService(), mock: true))
}
