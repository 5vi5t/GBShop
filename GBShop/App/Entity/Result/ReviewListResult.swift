//
//  ReviewListResult.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation

struct ReviewListResult: Codable {
    let result: Int?
    let pageNumber: Int?
    let reviews: [Review]?
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case result, reviews
        case pageNumber = "page_number"
        case errorMessage = "error_message"
    }
}

struct Review: Codable {
    let userId: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case userId = "id_user"
        case text
    }
}
