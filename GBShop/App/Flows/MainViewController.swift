//
//  MainViewController.swift
//  GBShop
//
//  Created by Константин on 08.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        auth()
        deauth()
        reg()
        editProfile()
        getGoodsList()
        getGood()
        addReview()
        removeReview()
        getReviewList()
        addToBasket()
        deleteFromBasket()
        payBasket()
    }
    
    // MARK: - Functions
    
    func auth() {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(
            username: "Somebody",
            password: "mypassword"
        ) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deauth() {
        let deauth = requestFactory.makeDeauthRequestFactory()
        deauth.logout(userId: 123) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func reg() {
        let reg = requestFactory.makeRegRequestFactory()
        let model = RegisterUserModel(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language")
        reg.registerUser(model: model) { response in
            switch response.result {
            case .success(let registerUser):
                print(registerUser)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func editProfile() {
        let editProfile = requestFactory.makeEditProfileRequestFactory()
        let model = ChangeUserDataModel(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language")
        editProfile.changeUserData(model: model) { response in
            switch response.result {
            case .success(let registerUser):
                print(registerUser)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGoodsList() {
        let getGoodsList = requestFactory.makeGetGoodsListRequestFactory()
        getGoodsList.getCatalogData(
            pageNumber: 1,
            categoryId: 1
        ) { response in
            switch response.result {
            case .success(let goodsList):
                print(goodsList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGood() {
        let getGood = requestFactory.makeGetGoodRequestFactory()
        getGood.getGood(by: 123) { response in
            switch response.result {
            case .success(let good):
                print(good)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addReview() {
        let addReview = requestFactory.makeAddReviewRequestFactory()
        addReview.addReview(
            userId: 123,
            text: "Текст отзыва"
        ) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removeReview() {
        let removeReview = requestFactory.makeRemoveReviewRequestFactory()
        removeReview.removeReview(commentId: 123) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getReviewList() {
        let getReviewList = requestFactory.makeGetReviewListRequestFactory()
        getReviewList.getReviewList(
            pageNumber: 1,
            productId: 123
        ) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }

    func addToBasket() {
        let addToBasket = requestFactory.makeAddToBasketRequestFactory()
        addToBasket.addToBasket(
            productId: 123,
            quantity: 1
        ) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }

    func deleteFromBasket() {
        let deleteFromBasket = requestFactory.makeDeleteFromBasketRequestFactory()
        deleteFromBasket.deleteFromBasket(
            productId: 123
        ) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }

    func payBasket() {
        let payBasket = requestFactory.makePayBasketRequestFactory()
        payBasket.payBasket(
            amount: 46600,
            amountMethod: "Visa"
        ) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
