//
//  GhibliAPIService.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/17/26.
//

import Foundation


protocol GhibliAPIService: Sendable { // we could do this with Combime but we are doing it with async/await
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
    
    func searchFilm(for searchTerm: String) async throws -> [Film] 
}
