//
//  MockFavouriteStorage.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 17/10/2026.
//

import Foundation

struct MockFavouriteStorage: FavouriteStorage {
    func save(for favouriteIDs: Set<Int>) {
        
    }
    
    func load() -> Set<Int> {
        [1423191]
    }
    
}
