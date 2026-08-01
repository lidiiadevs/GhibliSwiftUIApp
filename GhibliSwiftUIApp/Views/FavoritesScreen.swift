//
//  FavoritesScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct FavoritesScreen: View {
    
    let filmsViewModel: FilmsViewModel
    
    var films: [Film] {
        //TODO: - get favorites
        // retrieve ids from storage
        // get data for favorite ids from films data
        return []
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView("No Favorites yer", systemImage: "heart")
                } else {
                    FilmListView(films: films)
                }
            }
                .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
}
