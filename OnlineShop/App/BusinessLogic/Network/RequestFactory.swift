//
//  RequestFactory.swift
//  OnlineShop
//
//  Created by Константин on 10.02.2023.
//

import Foundation
import Alamofire

class RequestFactory {
    // MARK: - Properties
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Functions
    
    private func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeDeauthRequestFactory() -> DeauthRequestFactory {
        let errorParser = makeErrorParser()
        return Deauth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRegRequestFactory() -> RegRequestFactory {
        let errorParser = makeErrorParser()
        return Reg(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeEditProfileRequestFactory() -> EditProfileRequestFactory {
        let errorParser = makeErrorParser()
        return EditProfile(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetGoodsListRequestFactory() -> GetGoodsListRequestFactory {
        let errorParser = makeErrorParser()
        return GetGoodsList(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetGoodRequestFactory() -> GetGoodRequestFactory {
        let errorParser = makeErrorParser()
        return GetGood(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParser = makeErrorParser()
        return AddReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeRemoveReviewRequestFactory() -> RemoveReviewRequestFactory {
        let errorParser = makeErrorParser()
        return RemoveReview(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeGetReviewListRequestFactory() -> GetReviewListRequestFactory {
        let errorParser = makeErrorParser()
        return GetReviewList(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParser = makeErrorParser()
        return AddToBasket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParser = makeErrorParser()
        return DeleteFromBasket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }

    func makePayBasketRequestFactory() -> PayBasketRequestFactory {
        let errorParser = makeErrorParser()
        return PayBasket(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
}
