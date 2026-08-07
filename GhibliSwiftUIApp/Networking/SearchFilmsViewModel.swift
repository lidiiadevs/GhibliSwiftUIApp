//
//  SearchFilmsView.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/6/26.
//

import Foundation
import Observation

@Observable
class SearchFilmsViewModel {
    
    var state: LoadingState<[Film]> = .idle
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibleService()) {
        self.service = service
    }
    
    func fetch(for searchTerm: String) async {
        try? await Task.sleep(for: .milliseconds(500))
        guard !Task.isCancelled else { return }
        //        guard !state.isLoading || state.error != nil else { return }
        
        guard !searchTerm.isEmpty else {
            return // []  // cannot return []
        }
        
        state = .loading
        
        do {
            let films = try await service.searchFilm(for: searchTerm)
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")
        } catch {
            self.state = .error("Unknown Error")
        }
    }
}
