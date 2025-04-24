//
//  CatFactViewModelTests.swift
//  CatFactsTests
//
//  Created by SubbaRao MV on 24/04/25.
//

import XCTest
@testable import CatFacts

final class CatFactViewModelTests: XCTestCase {
    
    var viewModel: CatFactViewModel!

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetCatData_Success() async throws {
        let expectation = expectation(description: "Cat Data is loaded successfully")
        viewModel = await CatFactViewModel(
            catFactServiceProtocol: MockCatFactServiceSuccess(),
            catImageServiceProtocol: MockCatImageServiceSuccess()
        )
        
        Task {
            await self.viewModel.getCatData()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        await MainActor.run {
            XCTAssertEqual(viewModel.catFact, "Cats drink milk")
            XCTAssertEqual(viewModel.catImageUrl, "https://example.com/cat.jpg")
            XCTAssertTrue(viewModel.showContent)
            XCTAssertFalse(viewModel.showError)
            XCTAssertFalse(viewModel.isLoading)
        }
    }
    
    func testGetCatData_Failure() async throws {
        let expectation = expectation(description: "Cats Data load failed")
        
        viewModel = await CatFactViewModel(
            catFactServiceProtocol: MockCatFactServiceFailure(),
            catImageServiceProtocol: MockCatImageServiceFailure()
        )
        
        Task {
            await viewModel.getCatData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)
        await MainActor.run {
            XCTAssertNil(viewModel.catFact)
            XCTAssertNil(viewModel.catImageUrl)
            XCTAssertTrue(viewModel.showError)
            XCTAssertFalse(viewModel.showContent)
            XCTAssertFalse(viewModel.isLoading)
        }
    }

}
