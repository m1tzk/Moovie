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
    
    let showFavouriteButton: Bool
    
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
                        .font(.title.bold())
                    
                    Text(movieInfo.movie.originalTitle)
                        .font(.subheadline.bold())
                        .foregroundStyle(Color.gray)
                        .padding(.bottom, 6)
                    
                    Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 2) {
                        GridRow {
                            Text("Популярность:")
                            Text("\((movieInfo.movie.popularity).formatted(.number.precision(.fractionLength(2))))")
                        }
                        
                        BetterMovieDetails(detailViewModel: detailViewModel)
                        
                        GridRow {
                            Text("Дата выхода:")
                            Group {
                                if let releaseDate = movieInfo.movie.releaseDate {
                                    Text("\(releaseDate)")
                                } else {
                                    Text("не указана")
                                }
                            }
                        }
                    }
                    Divider()
                    
                    Text("Описание")
                        .font(.title3)
                    
                    if let description = movieInfo.movie.description {
                        Text("\(description)")
                    } else {
                        Text("Описание не предоставлено")
                    }

                    Divider()
                    
                    switch detailViewModel.state {
                    case .idle:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .loaded(let movieScreenData):
                        
                        Text("Актерcкий состав")
                            .font(.title3)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(movieScreenData.cast) { actor in
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 150, height: 220)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .overlay {
                                            VStack {
                                                Group {
                                                    if let profilePic = actor.actorPersonImage {
                                                        ProfilePictureView(profilePic: profilePic)
                                                    } else {
                                                        placeholderProfileImage
                                                    }
                                                }
                                                .padding(.top, 12)
                                                
                                                
                                                Spacer()
                                                
                                                
                                                Text(actor.actorPersonData.name)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(2)
                                                
                                                if let role = actor.actorPersonData.role {
                                                    Text(role)
                                                        .font(.subheadline.bold())
                                                        .foregroundStyle(Color.gray)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                } else {
                                                    Text("")
                                                }
                                                
                                                
                                                Spacer()
                                            }
                                        }
                                }
                            }
                        }
                        
                        Divider()
                        
                        Text("Съемочная группа")
                            .font(.title3)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(movieScreenData.crew) { crewMember in
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 150, height: 220)
                                        .clipShape(.rect(cornerRadius: 12))
                                        .overlay {
                                            VStack {
                                                Group {
                                                    if let profilePic = crewMember.crewPersonImage {
                                                        ProfilePictureView(profilePic: profilePic)
                                                    } else {
                                                        placeholderProfileImage
                                                    }
                                                }
                                                .padding(.top, 12)
                                                
                                                
                                                Spacer()
                                                
                                                
                                                Text(crewMember.crewPersonData.name)
                                                    .multilineTextAlignment(.center)
                                                    .lineLimit(2)
                                                
                                                if let job = crewMember.crewPersonData.job {
                                                    Text(job)
                                                        .font(.subheadline.bold())
                                                        .foregroundStyle(Color.gray)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(2)
                                                } else {
                                                    Text("")
                                                }
                                                
                                                
                                                Spacer()
                                            }
                                        }
                                }
                            }
                        }
                    case .error(let error):
                        Text(error)
                            .foregroundStyle(.primary)
                    }
                }
                .padding()
                
            }
            .toolbar {
                FavouriteButton(movieID: movieInfo.movie.id,
                                favouritesViewModel: favouritesViewModel,
                                showFavouriteButton: showFavouriteButton
                )
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
    
    private var placeholderProfileImage: some View {
        Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: 120, height: 120)
            .overlay {
                Image(systemName: "person.bubble")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
            
    }
}


struct BetterMovieDetails: View {
    
    let detailViewModel: MovieDetailsViewModel
    
    var body: some View {
        switch detailViewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .loaded(let movieScreenData):
            GridRow {
                Text("Рейтинг: ")
                if let voteAvgRating = movieScreenData.movieDetails.voteAvgRating {
                    Text("\(voteAvgRating.formatted(.number.precision(.fractionLength(2)))) / 10")
                } else {
                    Text("отсутствует")
                }
            }
            GridRow {
                Text("Длительность: ")
                if let runtime = movieScreenData.movieDetails.runtime {
                    Text("\(runtime) мин.")
                } else {
                    Text("не указана")
                }
            }
            GridRow {
                Text("Бюджет: ")
                if let budget = movieScreenData.movieDetails.budget {
                    Text("\(budget) $")
                } else {
                    Text("не указан")
                }
            }
            GridRow {
                Text("Сборы: ")
                if let revenue = movieScreenData.movieDetails.revenue {
                    Text("\(revenue) $")
                } else {
                    Text("не указаны")
                }
            }
        case .error(let error):
            Text(error)
                .foregroundStyle(.primary)
        }
    }
}


//#Preview {
//    NavigationStack {
//        MovieDetailView(movieInfo: MovieMainData.example, favouritesViewModel: FavouritesViewModel(service: MockFavouriteStorage()))
//    }
//}
