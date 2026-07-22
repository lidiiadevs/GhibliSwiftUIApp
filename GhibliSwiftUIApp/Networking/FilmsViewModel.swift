//
//  FilmsVIewModel.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/16/26.
//

import Foundation
import Observation


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
        
        guard state == .idle else { return } //gotta make State enum Equatable to use ==
        
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
