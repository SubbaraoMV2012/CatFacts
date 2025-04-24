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
        if let url = URL(string: "https://meowfacts.herokuapp.com/") {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fact = try JSONDecoder().decode(CatFact.self, from: data)
            return fact.data.first ?? ""
        }
        return ""
    }
}
