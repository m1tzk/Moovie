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
    
    var body: some View {
        VStack(alignment: .leading){
            
            Image(uiImage: movieInfo.backdropImage!)
            
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
        .task {
            await detailViewModel.fetch(for: movieInfo)
        }
    }
}

#Preview {
    MovieDetailView(movieInfo: MovieMainData.example)
}
