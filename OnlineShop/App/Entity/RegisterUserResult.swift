//
//  RegisterUserResult.swift
//  OnlineShop
//
//  Created by Константин on 11.02.2023.
//

import Foundation

struct RegisterUserResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
        case errorMessage = "error_message"
    }
}
