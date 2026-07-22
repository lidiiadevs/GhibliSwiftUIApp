//
//  APIError.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 7/20/26.
//


import Foundation


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
