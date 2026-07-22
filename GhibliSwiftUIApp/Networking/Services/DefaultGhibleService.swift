//
//  DefaultGhibleService.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/17/26.
//

import Foundation

struct DefaultGhibleService: GhibliAPIService {
    
    
    func fetch<T: Decodable> (from URLString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: URLString) else { throw APIError.invalidURL }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }

    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }
//        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else { throw APIError.invalidURL }
//
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                throw APIError.invalidResponse
//            }
//            
//            return try JSONDecoder().decode([Film].self, from: data)
//        } catch let error as DecodingError {
//            throw APIError.decoding(error)
//        } catch let error as URLError {
//            throw APIError.networkError(error)
//        }
//    }
}
    

//class AuthRepository { // we csll it a repository
//    var token: String?
//    
////    let service: AuthService // can also have service layers underneath. So basically there are more layers behind that back up the UI.
//    
//    
//    func refresh() {
//        //fetch and update token
//        token = "new token"
//    } //this func modifies the state
//}
