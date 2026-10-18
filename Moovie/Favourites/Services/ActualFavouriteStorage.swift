//
//  ActualFavouriteStorage.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 17/10/2026.
//
import Foundation

struct ActualFavouriteStorage: FavouriteStorage {
    
    private let favouritesKey = "Moovie.FavouriteMovies"
    
    func load() -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: favouritesKey) as? [Int] ?? []
        return Set(array)
    }
    
    func save(for favouriteIDs: Set<Int>) {
        UserDefaults.standard.set(Array(favouriteIDs), forKey: favouritesKey)
    }
    

}
