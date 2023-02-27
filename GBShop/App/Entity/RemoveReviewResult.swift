//
//  RemoveReviewResult.swift
//  GBShop
//
//  Created by Константин on 23.02.2023.
//

import Foundation

struct RemoveReviewResult: Codable {
    let result: Int
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
