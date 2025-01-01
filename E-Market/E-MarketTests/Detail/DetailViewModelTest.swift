//
//  DetailViewModelTest.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import XCTest
@testable import E_Market

final class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailsViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockCartHandler: MockCartHandler!
    var mockProduct: Product!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockCartHandler = MockCartHandler()
        mockProduct = Product(
            createdAt: "2023-01-01",
            name: "Test Product",
            image: "https://example.com/test-image.png",
            price: "10.99",
            description: "A test product",
            model: "Model A",
            brand: "Brand X",
            id: "1",
            quantity: nil
        )
        viewModel = DetailsViewModel(product: mockProduct, networkManager: mockNetworkManager, cartManager: mockCartHandler)
    }


    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockCartHandler = nil
        mockProduct = nil
        super.tearDown()
    }

    // MARK: - Tests
    func testAddToCartNewProduct() {
        let expectation = XCTestExpectation(description: "New product added to cart")

        viewModel.addToCart(product: mockProduct) { error in
            // Assert
            XCTAssertNil(error)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.count, 1)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.id, self.mockProduct.id)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.quantity, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func testAddToCartSuccess() {
        let newProduct = Product(
            createdAt: "2023-01-04",
            name: "Product 4",
            image: "https://example.com/product4.png",
            price: "25.00",
            description: "Description for Product 4",
            model: "Model A",
            brand: "Brand X",
            id: "4",
            quantity: nil
        )
        let expectation = XCTestExpectation(description: "Product added to cart successfully")

        viewModel.addToCart(product: newProduct) { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.count, 1)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.id, newProduct.id)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.quantity, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }


    func testAddToCartExistingProduct() {
        var existingProduct = mockProducts[0]
        existingProduct.quantity = 1
        mockCartHandler.mockCartItems = [existingProduct]
        let expectation = XCTestExpectation(description: "Existing product quantity updated in cart")

        viewModel.addToCart(product: existingProduct) { error in
            // Assert
            XCTAssertNil(error)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.count, 1)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.id, existingProduct.id)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.first?.quantity, 2) // Miktar artırılmalı
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }


    func testAddToCartFailure() {
        mockCartHandler.mockError = .addObjectError
        let newProduct = mockProducts[0]
        let expectation = XCTestExpectation(description: "Adding product to cart failed")

        viewModel.addToCart(product: newProduct) { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .addObjectError)
            XCTAssertEqual(self.mockCartHandler.mockCartItems.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}
