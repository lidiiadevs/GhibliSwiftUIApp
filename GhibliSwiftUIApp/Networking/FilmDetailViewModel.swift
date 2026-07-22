//
//  FilmDetailViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/20/26.
//

import Foundation
import Observation

class FilmDetailViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }
    
    var state: State = .idle
    let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibleService()) {
        self.service = service
    }
    
    func fetch(for film: Film) async throws {
        
        guard state != .loading else { return }
        
        state = .loading
        var loadedPeople: [Person] = []
    
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in // Run multiple async tasks in parallel, collect their results, and if any task throws an error, throw that error and cancel the remaining tasks. 
                
                for personInfoURL in film.people {
                   // print("start fetch for \(personInfoURL)")
                    group.addTask {
                    try await self.service.fetchPerson(from: personInfoURL)
                    }
                }
                //collect results as they complete
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
            
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
        
    }
}


import Playgrounds

#Playground {
    let service = MockGhibliService()
    let vm = FilmDetailViewModel(service: service)
    
    let film = service.fetchFilm()
    try await vm.fetch(for: film)
    
    switch vm.state {
    case .loading: print("Loading")
    case .idle: print("idle")
    case .loaded(let people):
        for person in people {
        print(person)
    }
    case .error(let error): print(error)
    }
}
