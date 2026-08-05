//
//  FavoritesViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/31/26.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    
    private(set) var favoriteIDs: Set<String> = []
    
    private let service: FavoriteStorage
    
    init(service: FavoriteStorage = DefaultFavoriteStorage()) {
        self.service = service
    }
    
    func load() {
        favoriteIDs = service.load()
//        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
//        favoriteIDs = Set(array) //...forKey(...) (like stringArray(forKey:)) = load (read) data
    }
    
    func save() {
        service.save(favoriteIDs: favoriteIDs)
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        save()
    }
    
    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }
}
