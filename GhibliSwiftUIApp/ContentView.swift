//
//  ContentView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/15/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filmsViewModel = FilmsViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        TabView {
            Tab("Movies", systemImage: "movieclapper") {
                FilmsScreen(filmsViewModel: filmsViewModel, favoritesViewModel: favoritesViewModel)
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(filmsViewModel: filmsViewModel, favoriteViewModel: favoritesViewModel)
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen(favoritesVewModel: favoritesViewModel)
            }
        }
        .task {
            favoritesViewModel.load()
            await filmsViewModel.fetch()
        }
        .setAppearanceTheme()
    }
}

#Preview {
    ContentView()
}
