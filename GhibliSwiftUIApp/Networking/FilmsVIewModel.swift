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
class FilmsVIewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    func fetch() async {
        
        guard state == .idle else { return } //gotta make State class Equatable to use ==
        
        state = .loading
        
        do {
            let films = try await fetchFilms()
            self.state = .loaded(films)
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
    
    private func fetchFilms() async throws -> [Film] {
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else { throw APIError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode([Film].self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
