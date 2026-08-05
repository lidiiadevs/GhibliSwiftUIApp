//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/16/26.
//

import SwiftUI

struct FilmListView: View {
    
    var films: [Film]
    let favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favoritesViewModel: favoritesViewModel)
            }
        }
        .navigationDestination(for: Film.self) {
            film in
            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: film.id)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            FilmImageView(urlPath: film.image)
                .frame(width: 100, height: 150)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(film.title)
                        .bold()
                    Spacer()
                    Button {
                        favoritesViewModel.toggleFavorite(filmID: film.id)
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorite ? .pink : .gray)
                    }
                    .buttonStyle(.plain)
                    .controlSize(.large) //makes heart bigger
                }
                .padding(.bottom, 5)
                
                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("Released \(film.releaseYear)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top)
        }
    }
}

/*
#Preview {

    @State @Previewable var favorites = FavoritesViewModel(service: MockFavoriteStorage())
    
   // FilmListView(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
        FilmListView(films: [Film.example], favoritesViewModel: favorites)
    .task {
            favorites.load()
        }
}
*/
