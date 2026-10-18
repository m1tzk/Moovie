//
//  FavouritesViewModel.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 17/10/2026.
//

import SwiftUI
import Observation

@Observable
class FavouritesViewModel {
    
    private(set) var favouriteIDs: Set<Int> = []
    
    private let service: FavouriteStorage
    
    init(service: FavouriteStorage = ActualFavouriteStorage()) {
        self.service = service
    }
    
    func load() {
        favouriteIDs = service.load()
    }
    
    private func save() {
        service.save(for: favouriteIDs)
    }
   
    func toggleFavourite(movieID: Int) {
        if favouriteIDs.contains(movieID) {
            favouriteIDs.remove(movieID)
        } else {
            favouriteIDs.insert(movieID)
        }
        
        save()
    }
    
    func isFavourite(movieID: Int) -> Bool {
        favouriteIDs.contains(movieID)
    }
}
