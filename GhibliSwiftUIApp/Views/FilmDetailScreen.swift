//
//  FilmDetailScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/22/26.
//

import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel
    
    @State private var viewModel = FilmDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                FilmImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal) //bc text was not in its place as suppose to
                    .clipped()
                
                VStack(alignment:.leading) {
                    Text(film.title)
                    
                    Divider()
                    
                    Text("Characters")
                        .font(.title3)
                    
                    switch viewModel.state {
                    case .idle: EmptyView()
                    case .loading: ProgressView()
                    case .loaded(let people):
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    case .error(let error):
                        Text(error)
                            .foregroundStyle(.pink)
                    }
                }
                .padding()
            }
            .toolbar {
                FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
                .buttonStyle(.plain)
                .controlSize(.large) //makes heart bigger
            }
            
            .task(id: film) {
                do {
                    try await viewModel.fetch(for: film)
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct FavoriteButton: View {
    
    let filmID: String
    let favoritesViewModel: FavoritesViewModel
    
    var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: filmID)
    }
    
    var body: some View {
        Button {
            favoritesViewModel.toggleFavorite(filmID: filmID)
        } label: {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundStyle(isFavorite ? .pink : .gray)
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailScreen(film: Film.example,
                         favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
    }
}
