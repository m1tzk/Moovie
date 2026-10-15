//
//  FavouritesView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 15/10/2026.
//

import SwiftUI

struct FavouritesView: View {
    
    let movieViewModel: MovieViewModel
    
    var movies: [MovieMainData] {
        //
        []
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if movies.isEmpty {
                    ContentUnavailableView("Закладок пока не добавлено", systemImage: "heart")
                } else {
                    MovieListView(movies: movies)
                }
            }
            .navigationTitle("Закладки")
        }
    }
}

#Preview {
    FavouritesView(movieViewModel: MovieViewModel(service: MockMovieService(), mock: true))
}
