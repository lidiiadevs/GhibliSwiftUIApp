//
//  FavoritesScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoriteViewModel: FavoritesViewModel
    
    var films: [Film] {
        //TODO: - get favorites
        // retrieve ids from storage
        let favorites = favoriteViewModel.favoriteIDs
        switch filmsViewModel.state {
        case .loaded(let films):
            return films.filter { favorites.contains($0.id) }
        default:
            return []
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yer", systemImage: "heart")
                } else {
                    FilmListView(films: films, favoritesViewModel: favoriteViewModel)
                }
            }
                .navigationTitle("Favorites")
        }
    }
}

#Preview {
    
//    @State @Previewable var favorites = FavoritesViewModel(service: MockFavoriteStorage())
//    
//    NavigationStack {
//        FilmListView(films: [Film.example], favoritesViewModel: favorites)
//    }
//    .task {
//            favorites.load()
//        }
    
    FavoritesScreen(filmsViewModel: FilmsViewModel.example, favoriteViewModel: FavoritesViewModel.example)
}
