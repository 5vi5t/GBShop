//
//  AddToBasketRequestFactory.swift
//  GBShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

protocol AddToBasketRequestFactory {
    func addToBasket(
        productId: Int,
        quantity: Int,
        completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void
    )
}
