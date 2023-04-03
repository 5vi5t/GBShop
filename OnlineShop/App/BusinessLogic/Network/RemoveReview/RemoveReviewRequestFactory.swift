//
//  RemoveReviewRequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation
import Alamofire

protocol RemoveReviewRequestFactory {
    func removeReview(
        commentId: Int,
        completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void
    )
}
