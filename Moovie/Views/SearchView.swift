//
//  SearchView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 15/10/2026.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchViewModel: SearchViewModel = SearchViewModel(service: ActualMovieService(), mock: false)
    @State private var text: String = ""
    let favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    ContentUnavailableView("Результатов нет, попробуйте ввести запрос", systemImage: "magnifyingglass")
                case .loading:
                    ProgressView() {
                        Text("Осуществляется поиск")
                    }
                case .loaded(let movieInfo):
                    MovieListView(movies: movieInfo, favouritesViewModel: favouritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.primary)
                }
            }
            .searchable(text: $text)
            .task(id: text) {
                await searchViewModel.fetch(for: text)
            }
        }
    }
}

//#Preview {
//    SearchView()
//}
