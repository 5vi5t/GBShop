//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
