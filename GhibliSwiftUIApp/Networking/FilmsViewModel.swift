//
//  FilmsVIewModel.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/16/26.
//

import Foundation
import Observation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return("URL is invalid")
        case .invalidResponse:
            return("Invalid response from server")
        case .decoding(let error):
            return("Failed to decode response: \(error.localizedDescription)")
        case .networkError(let error):
            return("Network error: \(error.localizedDescription)")
        }
    }
}

@Observable
class FilmsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibleService()) {
        self.service = service
    }
    
    func fetch() async {
        
        guard state == .idle else { return } //gotta make State class Equatable to use ==
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")
        } catch {
            self.state == .error("Unknown Error")
        }
    }
    
}
