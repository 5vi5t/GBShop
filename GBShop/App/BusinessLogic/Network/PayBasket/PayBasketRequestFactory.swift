//
//  PayBasketRequestFactory.swift
//  GBShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(
        amount: Int,
        amountMethod: String,
        completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void
    )
}
