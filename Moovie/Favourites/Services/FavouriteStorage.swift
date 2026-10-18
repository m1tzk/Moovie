//
//  FavouriteStorage.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 17/10/2026.
//

import Foundation

protocol FavouriteStorage {
    func load() -> Set<Int>
    func save(for favouriteIDs: Set<Int>)
}
