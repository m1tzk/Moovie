import SwiftUI
import UIKit

struct FavouriteButton: View {
    
    let movieID: Int
    let favouritesViewModel: FavouritesViewModel
    
    var isFavourite: Bool {
        favouritesViewModel.isFavourite(movieID: movieID)
    }
    
    var body: some View {
        
        Button {
            favouritesViewModel.toggleFavourite(movieID: movieID)
        } label: {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .foregroundStyle(isFavourite ? Color.red : Color.gray)
        }
    }
}