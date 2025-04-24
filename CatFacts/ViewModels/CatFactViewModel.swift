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
    @Published var isLoading: Bool = false
    @Published var showContent: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
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
        isLoading = true
        showContent = false
        do {
            async let catImageUrlString = try catImageServiceProtocol.getCatImageURL()
            async let catfactMessage = try catFactServiceProtocol.getCatFact()
            self.catImageUrl = try await catImageUrlString
            self.catFact = try await catfactMessage
            withAnimation {
                showContent = true
            }
        } catch {
            showError = true
            errorMessage = error.localizedDescription.isEmpty ? "Something went wrong while fetching cat content" : error.localizedDescription
        }
        isLoading = false
    }
    
}
