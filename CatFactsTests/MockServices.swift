//
//  MockServices.swift
//  CatFactsTests
//
//  Created by SubbaRao MV on 24/04/25.
//

import XCTest
@testable import CatFacts

class MockCatFactServiceSuccess: CatFactServiceProtocol {
    func getCatFact() async throws -> String {
        return "Cats drink milk"
    }
}

class MockCatImageServiceSuccess: CatImageServiceProtocol {
    func getCatImageURL() async throws -> String {
        return "https://example.com/cat.jpg"
    }
}

class MockCatFactServiceFailure: CatFactServiceProtocol {
    func getCatFact() async throws -> String {
        throw NetworkError.networkError(NSError(domain: "", code: -1, userInfo: nil))
    }
}

class MockCatImageServiceFailure: CatImageServiceProtocol {
    func getCatImageURL() async throws -> String {
        throw NetworkError.networkError(NSError(domain: "", code: -1, userInfo: nil))
    }
}
