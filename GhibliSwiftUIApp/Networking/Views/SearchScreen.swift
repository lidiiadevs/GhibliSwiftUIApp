//
//  SearchScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct SearchScreen: View {
    
    @State private var text: String = ""
    @State private var filmsViewModel = FilmsViewModel()
    @State private var searchViewModel: SearchFilmsViewModel
    
    let favoritesViewModel: FavoritesViewModel
    
    init(
        favoritesVewModel: FavoritesViewModel,
        service: GhibliAPIService = DefaultGhibliService()
    ) {
        self.favoritesViewModel = favoritesVewModel
        self._searchViewModel = State(
            initialValue: SearchFilmsViewModel(service: service)
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if text.isEmpty {
                    
                    // No search → show all films
                    switch filmsViewModel.state {
                    case .idle:
                        ProgressView()
                        
                    case .loading:
                        ProgressView()
                        
                    case .error(let error):
                        Text(error)
                        
                    case .loaded(let films):
                        FilmListView(
                            films: films,
                            favoritesViewModel: favoritesViewModel
                        )
                    }
                    
                } else {
                    
                    // Search started → show search results
                    switch searchViewModel.state {
                    case .idle:
                        EmptyView()
                        
                    case .loading:
                        ProgressView()
                        
                    case .error(let error):
                        Text(error)
                        
                    case .loaded(let films):
                        FilmListView(
                            films: films,
                            favoritesViewModel: favoritesViewModel
                        )
                    }
                }
            }
            .navigationTitle("Search Ghibli Movies")
            .searchable(text: $text)
            
            // Load the complete list once
            .task {
                await filmsViewModel.fetch()
            }
            
            // Search only when text changes and is not empty
            .task(id: text) {
                guard !text.isEmpty else { return }
                await searchViewModel.fetch(for: text)
            }
        }
    }
}

//struct SearchScreen: View {
//    
//    @State private var text: String = ""
//    @State private var searchViewModel = SearchFilmsViewModel()
//    let favoritesViewModel: FavoritesViewModel
//    
//    init(favoritesVewModel: FavoritesViewModel, service: GhibliAPIService = DefaultGhibliService()) {
//        self.favoritesViewModel = favoritesVewModel
//        self.searchViewModel = SearchFilmsViewModel(service: service)
//    }
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                switch searchViewModel.state {
//                case .idle:
//                    Text("Show search here")
//                case .loading:
//                    ProgressView()
//                case .error(let error):
//                    Text(error)
//                case .loaded(let films):
//                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
//                }
//            }
//            .navigationTitle("Search Ghibli Movies")
//            .searchable(text: $text)
//            .task(id: text) {
//                await searchViewModel.fetch(for: text)
//            }
//        }
//    }
//}



#Preview {
    SearchScreen(favoritesVewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
