//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(
        userId: Int,
        text: String,
        completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void
    )
}
