//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/16/26.
//

import SwiftUI

struct FilmListView: View {
    
    // films: [Film]
    
    @State private var filmsViewModel = FilmsVIewModel()
    
    var body: some View {
        
        switch filmsViewModel.state {
        case .idle:
            Text("No Films yet")
                .task {
                    await filmsViewModel.fetch()
                }
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
}

#Preview {
    FilmListView()
}
