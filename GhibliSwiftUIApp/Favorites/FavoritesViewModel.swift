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
    
    var favoriteIDs: Set<String> = []
    
    func load() {
        
    }
    
    func save() {
        
    }
    
    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
    }
}
