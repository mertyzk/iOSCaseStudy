//
//  CartViewModelTest.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import XCTest
@testable import E_Market

final class CartViewModelTests: XCTestCase {
    var viewModel: CartViewModel!
    var mockCartHandler: MockCartHandler!
    
    
    override func setUp() {
        super.setUp()
        mockCartHandler = MockCartHandler()
        viewModel = CartViewModel(cartManager: mockCartHandler)
    }

    
    override func tearDown() {
        viewModel = nil
        mockCartHandler = nil
        super.tearDown()
    }

    
    // MARK: - Tests
    func testGetCartsFromDBSuccess() {
        mockCartHandler.mockCartItems = mockProducts
        let expectation = XCTestExpectation(description: "Cart fetched successfully")
        
        viewModel.onChangeCart = { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.cartItems.count, mockProducts.count)
            XCTAssertEqual(self.viewModel.cartItems.first?.name, mockProducts.first?.name)
            expectation.fulfill()
        }

        viewModel.getCartsFromDB()

        wait(for: [expectation], timeout: 1.0)
    }

    
    func testGetCartsFromDBFailure() {
        mockCartHandler.mockError = .fetchDataError
        let expectation = XCTestExpectation(description: "Cart fetch failed")
        
        viewModel.onChangeCart = { error in
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .fetchDataError)
            XCTAssertEqual(self.viewModel.cartItems.count, 0)
            expectation.fulfill()
        }

        viewModel.getCartsFromDB()

        wait(for: [expectation], timeout: 1.0)
    }

    
    func testIncreaseItemQuantity() {
        mockCartHandler.mockCartItems = mockProducts
        let productToUpdate = mockProducts[0]
        let expectation = XCTestExpectation(description: "Product quantity increased")

        viewModel.getCartsFromDB()
        viewModel.onChangeCart = { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.cartItems[0].quantity, 3)
            expectation.fulfill()
        }

        viewModel.increaseItemQuantity(product: productToUpdate)

        wait(for: [expectation], timeout: 5.0)
    }

    
    func testDecreaseItemQuantity() {
        mockCartHandler.mockCartItems = mockProducts
        let productToUpdate = mockProducts[0]
        let expectation = XCTestExpectation(description: "Product quantity decreased")

        viewModel.getCartsFromDB()
        viewModel.onChangeCart = { error in

            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.cartItems[0].quantity, 1)
            expectation.fulfill()
        }

        viewModel.decreaseItemQuantity(product: productToUpdate)

        wait(for: [expectation], timeout: 2.0)
    }

    
    func testDeleteAllProducts() {
        mockCartHandler.mockCartItems = mockProducts
        let expectation = XCTestExpectation(description: "All products removed from cart")

        viewModel.deleteAllProducts { error in
            XCTAssertNil(error)
            XCTAssertEqual(self.viewModel.cartItems.count, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    
    func testTotalPrice() {
        mockCartHandler.mockCartItems = mockProducts
        viewModel.getCartsFromDB()
        
        let expectedTotalPrice = mockProducts.reduce(0) { total, product in
            let price = Double(product.price ?? "0") ?? 0
            return total + (price * Double(product.quantity ?? 0))
        }

        XCTAssertEqual(viewModel.totalPrice, expectedTotalPrice)
    }
}
