//
//  LoadingState.swift
//  GhibliSwiftUIApp
//
//  Created by Lidiia Diachkovskaia on 8/6/26.
//

import Foundation

enum LoadingState<T> { // generic
        case idle
        case loading
        case loaded(T)
        case error(String)

    var isLoading:  Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .loaded(let value) = self { return value }
        return nil
    }
    
    var error: String? {
        if case .error(let message) = self { return message }
        return nil
    }
}
