//
//  ContentView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 05/10/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movieViewModel: MovieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
    
    @State private var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        TabView {
            Tab("Фильмы", systemImage: "movieclapper") {
                MovieView(
                    movieViewModel: movieViewModel,
                    favouritesViewModel: favouritesViewModel
                )
            }
            
            Tab("Закладки", systemImage: "heart") {
                FavouritesView(
                    movieViewModel: movieViewModel,
                    favouritesViewModel: favouritesViewModel
                )
            }
            
            Tab("Настройки", systemImage: "gear") {
                SettingView()
            }
            
            Tab("Поиск", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
        .task {
            favouritesViewModel.load()
            await movieViewModel.fetch()
        }
    }
}

#Preview {
    ContentView()
}
