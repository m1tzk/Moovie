//
//  LoadingState.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 18/10/2026.
//

import Foundation

enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        } else {
            return false
        }
    }
    
    var data: T? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
    
    var error: String? {
        if case .error(let errorMessage) = self {
            return errorMessage
        }
        return nil
    }
}
