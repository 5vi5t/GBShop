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
        sleep(1)
        deauth()
        sleep(1)
        reg()
        sleep(1)
        editProfile()
        sleep(1)
        getGoodsList()
        sleep(1)
        getGood()
    }
    
    // MARK: - Functions
    
    func auth() {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(username: "Somebody",
                   password: "mypassword") { response in
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
        reg.registerUser(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language") { response in
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
        editProfile.changeUserData(
            userId: 123,
            username: "Somebody",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language") { response in
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
        getGoodsList.getCatalogData(pageNumber: 1,
                                    categoryId: 1) { response in
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
        getGood.getGood(by: 1) { response in
            switch response.result {
            case .success(let good):
                print(good)
            case .failure(let error):
                print(error)
            }
        }
    }
}
