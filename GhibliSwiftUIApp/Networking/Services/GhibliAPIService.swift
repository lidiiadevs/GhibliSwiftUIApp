//
//  GhibliAPIService.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/17/26.
//

import Foundation


protocol GhibliAPIService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
}
