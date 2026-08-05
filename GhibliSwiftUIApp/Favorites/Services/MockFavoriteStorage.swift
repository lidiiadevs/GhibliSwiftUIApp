//
//  MockFavoriteStorage.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/3/26.
//

import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    func load() -> Set<String> {
        return Set<String>(["2baf70d1-42bb-4437-b551-e5fed5a87abe"])
    }
    
    func save(favoriteIDs: Set<String>) {
    }
    
    
}
