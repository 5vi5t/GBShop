//
//  PayBasketTests.swift
//  OnlineShopTests
//
//  Created by Константин on 28.02.2023.
//

import XCTest
@testable import OnlineShop

final class PayBasketTests: XCTestCase {
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

    func testPayBasketWithValidValues() {
        let amount = 46600
        let amountMethod = "Visa"
        let expectation = XCTestExpectation(description: #function)
        let payBasket = requestFactory.makePayBasketRequestFactory()

        payBasket.payBasket(
            amount: amount,
            amountMethod: amountMethod
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertEqual(46600, result.amount)
                XCTAssertNotNil(result.balance)
                XCTAssertNotNil(result.products)
                XCTAssertNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPayBasketWithInvalidValues() {
        let amount = 0
        let amountMethod = ""
        let expectation = XCTestExpectation(description: #function)
        let payBasket = requestFactory.makePayBasketRequestFactory()

        payBasket.payBasket(
            amount: amount,
            amountMethod: amountMethod
        ) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNil(result.amount)
                XCTAssertNil(result.balance)
                XCTAssertNil(result.products)
                XCTAssertNotNil(result.errorMessage)
            case .failure:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
