//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/16/26.
//

import SwiftUI

struct FilmListView: View {
    
    // films: [Film]
    
    var filmsViewModel = FilmsViewModel()
    
    var body: some View {
        NavigationStack {
            switch filmsViewModel.state {
            case .idle:
                Text("No Films yet")
            case .loading:
                ProgressView {
                    Text("Loading ...")
                }
            case .loaded(let films):
                List(films) {
                    Text($0.title)
                }
            case .error(let error):
                Text(error)
                    .foregroundStyle(.pink)
            }
            
            // List(films)
            List(filmsViewModel.films) {
                Text($0.title)
            }
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    @State @Previewable var vm = FilmsViewModel(service: MockGhibliService())
    
//    FilmListView(filmsViewModel: FilmsViewModel(service: MockGhibliService()))
    FilmListView(filmsViewModel: vm)
}
