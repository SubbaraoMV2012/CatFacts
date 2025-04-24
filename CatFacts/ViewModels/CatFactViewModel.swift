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
        withAnimation {
            isLoading = true
            showError = false
            showContent = false
        }
        do {
            async let fact = try catFactServiceProtocol.getCatFact()
            async let imageUrl = try catImageServiceProtocol.getCatImageURL()
            
            let (factResult, imageResult) = try await (fact, imageUrl)
            
            withAnimation(.easeInOut(duration: 0.5)) {
                self.catFact = factResult
                self.catImageUrl = imageResult
                self.showContent = true
            }
        } catch {
            self.errorMessage = (error as? LocalizedError)?.errorDescription ?? "Something went wrong"
            showError = true
        }
        withAnimation {
            isLoading = false
        }
    }
}
