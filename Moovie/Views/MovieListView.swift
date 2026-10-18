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
    let favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        
        List(movies) { movie in
            NavigationLink(value: movie) {
                FilmRow(movie: movie, favouritesViewModel: favouritesViewModel)
            }
            .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .navigationDestination(for: MovieMainData.self) { movie in
            MovieDetailView(
                movieInfo: movie,
                favouritesViewModel: favouritesViewModel
            )
        }
    }
}

private struct FilmRow: View {
    
    let movie: MovieMainData
    let favouritesViewModel: FavouritesViewModel
    
    var body: some View {
        HStack {
            MovieImageView(image: movie.posterImage!)
                .frame(width: 100, height: 150)
            
            HStack {
                VStack(alignment: .leading){
                    Text(movie.movie.title)
                        .bold()
                    
                    Text("Рейтинг: \((movie.movie.popularity).formatted(.number.precision(.fractionLength(2))))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text("Дата выхода: \(movie.movie.releaseDate ?? "")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                FavouriteButton(movieID: movie.movie.id, favouritesViewModel: favouritesViewModel)
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
            }
            
        }
    }
}

//#Preview {
//    
//    @State @Previewable var movieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
//    
//    MovieListView(movies: movieViewModel.fetch(), favouritesViewModel: f)
//}
