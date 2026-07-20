//
//  DefaultGhibleService.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/17/26.
//

import Foundation

struct DefaultGhibleService: GhibliAPIService {
    func fetchFilms() async throws -> [Film] {
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
