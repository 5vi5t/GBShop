//
//  LogoutResult.swift
//  OnlineShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation

struct LogoutResult: Codable {
    let result: Int
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage = "error_message"
    }
}
