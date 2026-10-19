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
    let showFavouriteButton: Bool
    
    var body: some View {
        
        List(movies) { movie in
            NavigationLink(value: movie) {
                FilmRow(movie: movie,
                        favouritesViewModel: favouritesViewModel,
                        showFavouriteButton: showFavouriteButton
                )
            }
            .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .navigationDestination(for: MovieMainData.self) { movie in
            MovieDetailView(
                movieInfo: movie,
                favouritesViewModel: favouritesViewModel,
                showFavouriteButton: showFavouriteButton
            )
        }
    }
}

private struct FilmRow: View {
    
    let movie: MovieMainData
    let favouritesViewModel: FavouritesViewModel
    let showFavouriteButton: Bool
    
    var body: some View {
        HStack {
            Group {
                if let posterImage = movie.posterImage {
                    MovieImageView(image: posterImage)
                } else {
                    placeholderPosterImage
                }
            }
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
                
                FavouriteButton(
                    movieID: movie.movie.id,
                    favouritesViewModel: favouritesViewModel,
                    showFavouriteButton: showFavouriteButton
                )
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
            }
            
        }
    }
    
    private var placeholderPosterImage: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay {
                Image(systemName: "film")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
            }
    }
}


//#Preview {
//    
//    @State @Previewable var movieViewModel = MovieViewModel(service: MockMovieService(), mock: true)
//    
//    MovieListView(movies: movieViewModel.fetch(), favouritesViewModel: f)
//}
