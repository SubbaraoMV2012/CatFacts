//
//  NetworkError.swift
//  CatFacts
//
//  Created by SubbaRao MV on 24/04/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .networkError(let error): return error.localizedDescription
        }
    }
}
