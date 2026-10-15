//
//  ContentView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 05/10/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movieViewModel: MovieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
    
    var body: some View {
        TabView {
            Tab("Фильмы", systemImage: "movieclapper") {
                MovieView(movieViewModel: movieViewModel)
            }
            
            Tab("Закладки", systemImage: "heart") {
                FavouritesView(movieViewModel: movieViewModel)
            }
            
            Tab("Настройки", systemImage: "gear") {
                SettingView()
            }
            
            Tab("Поиск", systemImage: "magnifyingglass", role: .search) {
                SearchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
