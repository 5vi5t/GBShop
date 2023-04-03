//
//  AddToBasketResult.swift
//  OnlineShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation

struct AddToBasketResult: Codable {
    let result: Int
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
