//
//  FavoriteStorage.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/3/26.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
