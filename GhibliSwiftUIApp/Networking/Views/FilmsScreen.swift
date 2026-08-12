//
//  FilmsScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/29/26.
//

import SwiftUI

struct FilmsScreen: View {
    
    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle:
                    Text("No Films yet")
                case .loading:
                    ProgressView {
                        Text("Loading ...")
                    }
                case .loaded(let films):
                    FilmListView(films: films, favoritesViewModel: favoritesViewModel)
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.pink)
                }
            }
                .navigationTitle("Ghibli Movies")
        }
//        .task {
//            await filmsViewModel.fetch()
//        } // this was fetched in ContentView
    }
}

#Preview {
    FilmsScreen(filmsViewModel: FilmsViewModel(service: MockGhibliService()), favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
}
