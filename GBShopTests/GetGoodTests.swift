//
//  GetGoodTests.swift
//  GBShopTests
//
//  Created by Константин on 16.02.2023.
//

import XCTest
@testable import GBShop

final class GetGoodTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func test_getGoodWithValidValues() {
        let id = 123
        let expectation = XCTestExpectation(description: #function)
        let getGood = requestFactory.makeGetGoodRequestFactory()
        
        getGood.getGood(by: id) { response in
            switch response.result {
            case .success(_): break
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
