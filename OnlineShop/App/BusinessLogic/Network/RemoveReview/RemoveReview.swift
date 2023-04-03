//
//  RemoveReview.swift
//  OnlineShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation
import Alamofire

class RemoveReview: AbstractRequestFactory {
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

extension RemoveReview {
    struct RemoveReview: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeReview"
        let commentId: Int
        var parameters: Parameters? {
            return [
                "id_comment": commentId
            ]
        }
    }
}

extension RemoveReview: RemoveReviewRequestFactory {
    // MARK: - Functions

    func removeReview(
        commentId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void
    ) {
        guard let baseUrl else { return }
        let requestModel = RemoveReview(
            baseUrl: baseUrl,
            commentId: commentId)
        request(request: requestModel, completionHandler: completionHandler)
    }
}
