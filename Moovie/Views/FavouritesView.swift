//
//  FavouritesView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 15/10/2026.
//

import SwiftUI

struct FavouritesView: View {
    
    let movieViewModel: MovieViewModel
    let favouritesViewModel: FavouritesViewModel
    
    var movies: [MovieMainData] {
        let favourites = favouritesViewModel.favouriteIDs
        switch movieViewModel.state {
        case .loaded(let movieInfo):
            return movieInfo.filter { favourites.contains($0.id) }
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if movies.isEmpty {
                    ContentUnavailableView("Закладок пока не добавлено", systemImage: "heart")
                } else {
                    MovieListView(
                        movies: movies,
                        favouritesViewModel: favouritesViewModel
                    )
                }
            }
            .navigationTitle("Закладки")
        }
    }
}

#Preview {
    FavouritesView(movieViewModel: MovieViewModel(service: MockMovieService(), mock: true), favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage()))
}
