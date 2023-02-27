//
//  GetReviewList.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation
import Alamofire

class GetReviewList: AbstractRequestFactory {
    // MARK: - Properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

    // MARK: - Construction

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension GetReviewList {
    struct ReviewList: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "reviewList"
        let pageNumber: Int
        let productId: Int
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_product": productId
            ]
        }
    }
}

extension GetReviewList: GetReviewListRequestFactory {
    // MARK: - Functions

    func getReviewList(
        pageNumber: Int,
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = ReviewList(
            baseUrl: baseUrl,
            pageNumber: pageNumber,
            productId: productId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
