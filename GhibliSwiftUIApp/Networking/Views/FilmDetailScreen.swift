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
            VStack(alignment: .leading, spacing: 7) {
                
                FilmImageView(urlPath: film.bannerImage)
                    .frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(film.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Grid(alignment: .leading) {
                        InfoRow(label: "Director", value: film.director)
                        InfoRow(label: "Producer", value: film.producer)
                        InfoRow(label: "Release Date", value: film.releaseYear)
                        InfoRow(label: "Running Time", value: "\(film.duration) minutes")
                        InfoRow(label: "Score", value: "\(film.score)/100")
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(film.description)
                    
                    Divider()
                    
                    CharacterSectionView(viewModel: viewModel)
                }
                .padding()
            }
        }
        .toolbar {
            FavoriteButton(filmID: film.id,
                           favoritesViewModel: favoritesViewModel)
        }
        .task(id: film) {
            do {
                try await viewModel.fetch(for: film)
            } catch {
                print(error)
            }
        }
    }
    
    fileprivate struct InfoRow: View {
        
        let label: String
        let value: String
        
        var body: some View {
            GridRow {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(width: 100, alignment: .leading)
                
                Text(value)
                    .font(.subheadline)
                
            }
        }
    }
    
    fileprivate struct CharacterSectionView:  View {
        
        let viewModel: FilmDetailViewModel
        
        var body: some View {
            GroupBox {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Characters")
                        .font(.headline)
                    
                    switch viewModel.state {
                    case .idle: EmptyView()
                    case .loading:  ProgressView()
                        
                    case .loaded(let people):
                        ForEach(people) { person in
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(person.name)
                                
                                HStack(spacing: 8) {
                                    Label(person.gender, systemImage: "person.fill")
                                    
                                    Text("Age: \(person.age)")
                                    Spacer()
                                    Label(person.eyeColor, systemImage: "eye")
                                    Text("Hair: \(person.hairColor)")
                                }
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .lineLimit(1)
                                
                            }
                        }
                        
                    case .error(let error):
                        Text(error)
                            .foregroundStyle(.pink)
                    }
                }
            }
        }
    }
}


//    var body: some View {
//        ScrollView {
//            VStack {
//                FilmImageView(urlPath: film.bannerImage)
//                    .frame(height: 300)
//                    .containerRelativeFrame(.horizontal) //bc text was not in its place as suppose to
//                    .clipped()
//
//                VStack(alignment:.leading) {
//                    Text(film.title)
//
//                    Divider()
//
//                    Text("Characters")
//                        .font(.title3)
//
//                    switch viewModel.state {
//                    case .idle: EmptyView()
//                    case .loading: ProgressView()
//                    case .loaded(let people):
//                        ForEach(people) { person in
//                            Text(person.name)
//                        }
//                    case .error(let error):
//                        Text(error)
//                            .foregroundStyle(.pink)
//                    }
//                }
//                .padding()
//            }
//            .toolbar {
//                FavoriteButton(filmID: film.id, favoritesViewModel: favoritesViewModel)
//                .buttonStyle(.plain)
//                .controlSize(.large) //makes heart bigger
//            }
//
//            .task(id: film) {
//                do {
//                    try await viewModel.fetch(for: film)
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//}
//
//
//
//#Preview {
//    NavigationStack {
//        FilmDetailScreen(film: Film.example,
//                         favoritesViewModel: FavoritesViewModel(service: MockFavoriteStorage()))
//    }
//}
