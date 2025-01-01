//
//  HomeViewModelTest.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import XCTest
@testable import E_Market

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockFavoriteHandler: MockFavoriteHandler!
    var mockCartHandler: MockCartHandler!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockFavoriteHandler = MockFavoriteHandler()
        mockCartHandler = MockCartHandler()
        
        viewModel = HomeViewModel(
            networkManager: mockNetworkManager,
            favoriteManager: mockFavoriteHandler,
            cartManager: mockCartHandler
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockFavoriteHandler = nil
        mockCartHandler = nil
        super.tearDown()
    }
    
    
    // MARK: - Tests
    func testFetchProductsSuccess() {
        mockNetworkManager.setMockResponse(for: ProductRequest.self, response: mockProducts)

        let request = ProductRequest(endpoint: Endpoint.getProductsByPagination(page: 1, limit: 4))

        mockNetworkManager.request(request) { result in
            switch result {
            case .success(let products):
                XCTAssertEqual(products.count, mockProducts.count)
                XCTAssertEqual(products.first?.name, "Product 1")
            case .failure:
                XCTFail("Request should have succeeded")
            }
        }
    }
    
    
    func testFetchProductsFailure() {
        let mockNetworkManager = MockNetworkManager()
        
        mockNetworkManager.setMockError(for: ProductRequest.self, error: .unableToComplete)

        let request = ProductRequest(endpoint: Endpoint.getProductsByPagination(page: 1, limit: 4))

        mockNetworkManager.request(request) { result in
            switch result {
            case .success:
                XCTFail("Request should have failed")
            case .failure(let error):
                XCTAssertEqual(error, .unableToComplete)
            }
        }
    }


    func testAddToFavorite() {
        let product = mockProducts[0]
        let expectation = XCTestExpectation(description: "Product added to favorites")
        
        viewModel.addToFavorite(product: product) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.mockFavoriteHandler.mockFavorites.count, 1)
            XCTAssertEqual(self.mockFavoriteHandler.mockFavorites.first?.id, product.id)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    
    func testAddToCart() {
        let product = mockProducts[0]
        let expectation = XCTestExpectation(description: "Product added to cart")
        
        viewModel.addToCart(product: product) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.count, 1)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.id, product.id)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.quantity, 1)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
