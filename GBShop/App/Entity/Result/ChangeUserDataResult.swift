//
//  ChangeUserDataResult.swift
//  GBShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation

struct ChangeUserDataResult: Codable {
    let result: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
