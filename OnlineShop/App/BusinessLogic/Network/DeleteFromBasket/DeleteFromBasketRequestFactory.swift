//
//  DeleteFromBasketRequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation
import Alamofire

protocol DeleteFromBasketRequestFactory {
    func deleteFromBasket(
        productId: Int,
        completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void
    )
}
