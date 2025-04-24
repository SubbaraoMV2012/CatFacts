//
//  CatFactViewModel.swift
//  CatFacts
//
//  Created by SubbaRao MV on 24/04/25.
//

import Foundation
import SwiftUI

@MainActor
class CatFactViewModel: ObservableObject {
    @Published var catFact: String?
    @Published var catImageUrl: String?
    private let catFactServiceProtocol: CatFactServiceProtocol
    private let catImageServiceProtocol: CatImageServiceProtocol
    
    init(catFactServiceProtocol: CatFactServiceProtocol = CatFactService(), catImageServiceProtocol: CatImageServiceProtocol = CatImageService()) {
        self.catFactServiceProtocol = catFactServiceProtocol
        self.catImageServiceProtocol = catImageServiceProtocol
        Task {
            await getCatData()
        }
    }
    
    func getCatData() async {
        do {
            async let catfactMessage = try catFactServiceProtocol.getCatFact()
            async let catImageUrlString = try catImageServiceProtocol.getCatImageURL()
            self.catFact = try await catfactMessage
            self.catImageUrl = try await catImageUrlString
        } catch {
            self.catFact = "Failed to load content"
            self.catImageUrl = ""
        }
    }
    
}
