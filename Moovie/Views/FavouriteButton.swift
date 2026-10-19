//
//  FavouriteButton.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 17/10/2026.
//


import SwiftUI
import UIKit

struct FavouriteButton: View {
    
    let movieID: Int
    let favouritesViewModel: FavouritesViewModel
    
    var isFavourite: Bool {
        favouritesViewModel.isFavourite(movieID: movieID)
    }
    
    let showFavouriteButton: Bool
    
    var body: some View {
        
        if showFavouriteButton {
            Button {
                favouritesViewModel.toggleFavourite(movieID: movieID)
            } label: {
                Image(systemName: isFavourite ? "heart.fill" : "heart")
                    .foregroundStyle(isFavourite ? Color.red : Color.gray)
            }
        }
    }
}
