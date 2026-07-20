//
//  GhibliAPIService.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/17/26.
//

import Foundation

protocol GhibliAPIService {
    func fetchFilms() async throws -> [Film]
}
