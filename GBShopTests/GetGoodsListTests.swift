//
//  GetGoodsListTests.swift
//  GBShopTests
//
//  Created by Константин on 16.02.2023.
//

import XCTest
@testable import GBShop

final class GetGoodsListTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testGetGoodsListWithValidValues() {
        let pageNumber = 1
        let categoryId = 1
        let expectation = XCTestExpectation(description: #function)
        let getGoodsList = requestFactory.makeGetGoodsListRequestFactory()
        
        getGoodsList.getCatalogData(pageNumber: pageNumber, categoryId: categoryId) { response in
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
