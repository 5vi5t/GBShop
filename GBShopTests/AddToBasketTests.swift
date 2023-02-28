//
//  AddToBasketTests.swift
//  GBShopTests
//
//  Created by Константин on 28.02.2023.
//

import XCTest
@testable import GBShop

final class AddToBasketTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var requestFactory: RequestFactory!

    // swiftlint:disable:next overridden_super_call
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    // swiftlint:disable:next overridden_super_call
    override func tearDownWithError() throws {
        requestFactory = nil
    }

    func testAddToBasketWithValidValues() {
        let productId = 123
        let quantity = 1
        let expectation = XCTestExpectation(description: #function)
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()

        addToBasket.addToBasket(
            productId: productId,
            quantity: quantity
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testAddToBasketWithInvalidValues() {
        let productId = 1
        let quantity = 0
        let expectation = XCTestExpectation(description: #function)
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()

        addToBasket.addToBasket(
            productId: productId,
            quantity: quantity
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNotNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
