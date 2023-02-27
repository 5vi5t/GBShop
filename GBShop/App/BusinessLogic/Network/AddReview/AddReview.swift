//
//  AddReview.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation
import Alamofire

class AddReview: AbstractRequestFactory {
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

extension AddReview {
    struct AddReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        let userId: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "text": text
            ]
        }
    }
}

extension AddReview: AddReviewRequestFactory {
    // MARK: - Functions

    func addReview(
        userId: Int,
        text: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = AddReview(
            baseUrl: baseUrl,
            userId: userId,
            text: text)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
