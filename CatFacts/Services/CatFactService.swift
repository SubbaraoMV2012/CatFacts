//
//  CatFactService.swift
//  CatFacts
//
//  Created by SubbaRao MV on 24/04/25.
//

import Foundation

protocol CatFactServiceProtocol {
    func getCatFact() async throws -> String
}

class CatFactService: CatFactServiceProtocol {
    func getCatFact() async throws -> String {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/") else {
            throw NetworkError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fact = try JSONDecoder().decode(CatFact.self, from: data)
            return fact.data.first ?? "No Cat fact found"
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
}
