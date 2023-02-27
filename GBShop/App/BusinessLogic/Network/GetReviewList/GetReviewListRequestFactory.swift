//
//  GetReviewListRequestFactory.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Alamofire

protocol GetReviewListRequestFactory {
    func getReviewList(
        pageNumber: Int,
        productId: Int,
        completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void
    )
}
