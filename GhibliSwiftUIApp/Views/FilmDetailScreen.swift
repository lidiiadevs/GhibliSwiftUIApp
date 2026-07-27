//
//  FilmDetailScreen.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/22/26.
//

import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    
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

#Preview {
    FilmDetailScreen(film: Film.example)
}
