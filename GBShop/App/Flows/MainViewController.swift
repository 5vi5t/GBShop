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
}
