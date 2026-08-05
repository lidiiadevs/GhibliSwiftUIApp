//
//  DefaultFavoriteStorage.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/3/26.
//

import Foundation

struct DefaultFavoriteStorage: FavoriteStorage {
    
    private let favoritesKey = "GhibliExplorer.FavoriteFilms"
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return Set(array) //...forKey(...) (like stringArray(forKey:)) = load (read) data
    }
    
    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey) //set(...) = save (write) data
    }
    
}
