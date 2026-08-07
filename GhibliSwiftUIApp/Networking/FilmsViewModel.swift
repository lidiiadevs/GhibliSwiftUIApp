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
        
    var state: LoadingState<[Film]> = .idle
    
    private let service: GhibliAPIService
    
    init(service: GhibliAPIService = DefaultGhibleService()) {
        self.service = service
    }
    
    func fetch() async {
        guard !state.isLoading || state.data != nil else { return } //gotta make State enum Equatable to use ==
        
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
    
    
    //MARK: - Preview
    
    static var example: FilmsViewModel {
        let vm = FilmsViewModel(service: MockGhibliService())
        vm.state = .loaded([Film.example])
        return vm
    }
}
