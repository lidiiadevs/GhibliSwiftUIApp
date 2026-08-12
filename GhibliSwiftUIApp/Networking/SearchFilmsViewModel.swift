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
    private var currentSearchTerm: String = ""
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibliService()) {
        self.service = service
    }
    
    func fetch(for searchTerm: String) async {
        self.currentSearchTerm = searchTerm
        
        //        guard !state.isLoading || state.error != nil else { return }
        
        guard !searchTerm.isEmpty else {
            state = .idle
            return // []  // cannot return []
        }
        
        state = .loading
        
        try? await Task.sleep(for: .milliseconds(500))
        guard !Task.isCancelled else { return }
        
        do {
            let films = try await service.searchFilm(for: searchTerm)
            self.state = .loaded(films)
        } catch {
            setError(error, for: searchTerm)
        }
//            catch let error as APIError {
//            self.state = .error(error.errorDescription ?? "Unknown Error")
//        } catch let error as CancellationError {
//            if currentSearchTerm == searchTerm {
//                self.state = .idle
//            }
//        } catch {
//            self.state = .error("Unknown Error")
//        }
    }
    
    func setError(_ error: Error, for searchTerm: String) {
        
        guard currentSearchTerm == searchTerm else { return }
        
        if let error = error as? APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } else {
            self.state = .error("unkown error")
        }
    }
}
