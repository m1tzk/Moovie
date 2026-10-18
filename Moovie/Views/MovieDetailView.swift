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
                
                MovieImageView(image: movieInfo.backdropImage!)
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
            .task {
                await detailViewModel.fetch(for: movieInfo)
            }
        }
    }
}



#Preview {
    NavigationStack {
        MovieDetailView(movieInfo: MovieMainData.example, favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage()))
    }
}
