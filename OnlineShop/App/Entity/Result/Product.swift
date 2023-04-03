//
//  Product.swift
//  OnlineShop
//
//  Created by Константин on 28.02.2023.
//

import Foundation

struct Product: Codable {
    let productId: Int
    let productName: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case productId = "id_product"
        case productName = "product_name"
        case price
    }
}
