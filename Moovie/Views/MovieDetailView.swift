//
//  MovieDetailView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 06/10/2026.

import SwiftUI
import UIKit


struct MovieDetailView: View {
    
    let movieInfo: MovieMainData
    
    @State private var detailViewModel = MovieDetailsViewModel()
    
    let favouritesViewModel: FavouritesViewModel

    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                Group {
                    if let backdropImage = movieInfo.backdropImage {
                        MovieImageView(image: backdropImage)
                    } else {
                        placeholderBackdropImage
                    }
                }
                .frame(height: 300)
                .containerRelativeFrame(.horizontal)

                
                VStack(alignment: .leading) {
                    Text(movieInfo.movie.title)
                    
                    Divider()
                    
                    Text("Актеры")
                        .font(.title3)
                    
                    switch detailViewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .loaded(let movieScreenData):
                        ForEach(movieScreenData.cast) { actor in
                            Text(actor.actorPersonData.name)
                        }
                    case .error(let error):
                        Text(error)
                            .foregroundStyle(.primary)
                    }
                }
                .padding()
                
            }
            .toolbar {
                FavouriteButton(movieID: movieInfo.movie.id, favouritesViewModel: favouritesViewModel)
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .task {
                await detailViewModel.fetch(for: movieInfo)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var placeholderBackdropImage: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay {
                Image(systemName: "film.stack")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }
    
}



#Preview {
    NavigationStack {
        MovieDetailView(movieInfo: MovieMainData.example, favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage()))
    }
}
