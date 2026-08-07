//
//  SearchFilmsView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/6/26.
//

import Foundation

struct SearchFilmsView: View {
    func fetch() async {
        
        guard state == .idle else { return } //gotta make State enum Equatable to use ==
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")
        } catch {
            self.state = .error("Unknown Error")
        }
    }
}
