//
//  CatImageService.swift
//  CatFacts
//
//  Created by SubbaRao MV on 24/04/25.
//

import Foundation

protocol CatImageServiceProtocol {
    func getCatImageURL() async throws -> String
}

class CatImageService: CatImageServiceProtocol {
    func getCatImageURL() async throws -> String {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = try JSONDecoder().decode([CatImage].self, from: data)
            return image.first?.url ?? ""
        } catch {
            throw NetworkError.networkError(error)
        }
    }
}
