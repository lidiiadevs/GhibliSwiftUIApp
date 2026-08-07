//
//  SearchScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    @State private var searchViewModel = SearchFilmsViewModel()
    let favoritesViewModel: FavoritesViewModel
    
    init(favoritesVewModel: FavoritesViewModel, service: GhibliAPIService = DefaultGhibleService()) {
        self.favoritesViewModel = favoritesVewModel
        self.searchViewModel = SearchFilmsViewModel(service: service)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                switch searchViewModel.state {
                case .idle:
                    Text("Show search here")
                case .loading:
                    ProgressView()
                case .error(let error):
                    Text(error)
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                }
            }
                .searchable(text: $text)
                .task(id: text) {
                    await searchViewModel.fetch(for: text)
                }
        }
    }
}

#Preview {
    SearchScreen(favoritesVewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
