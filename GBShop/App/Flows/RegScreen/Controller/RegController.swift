//
//  RegController.swift
//  GBShop
//
//  Created by Константин on 19.03.2023.
//

import UIKit

class RegController<View: RegView>: BaseViewController<View> {
    // MARK: - Properties
    private let reg: RegRequestFactory
    private var regCredentials: RegCredentials?

    var onReg: VoidClosure?

    // MARK: - Construction
    init(requestFactory: RequestFactory) {
        self.reg = requestFactory.makeRegRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTap()
        nextTextField()
        addRegData()
        signUp()
    }

    // MARK: - Functions
    private func signUp() {
        rootView.pressedSignUpButton = { [weak self] in
            guard
                let creds = self?.regCredentials,
                let model = self?.makeRegisterUserModel(creds)
            else { return }
            self?.reg.registerUser(model: model) { response in
                switch response.result {
                case .success(let result):
                    if result.result == 1 {
                        self?.onReg?()
                        return
                    }
                    guard
                        let viewInputData = self?.makeRegViewInputData(with: result.errorMessage)
                    else { return }
                    DispatchQueue.main.async {
                        self?.rootView.update(with: viewInputData)
                    }
                case .failure(let error):
                    guard
                        let viewInputData = self?.makeRegViewInputData(with: error.errorDescription)
                    else { return }
                    DispatchQueue.main.async {
                        self?.rootView.update(with: viewInputData)
                    }
                }
            }
        }
    }

    private func makeRegViewInputData(with error: String?) -> RegViewInputData {
        return RegViewInputData(errorMessage: error)
    }

    private func makeRegisterUserModel(_ creds: RegCredentials) -> RegisterUserModel {
        return RegisterUserModel(
            userId: creds.userId,
            username: creds.login,
            password: creds.password,
            email: creds.email,
            gender: creds.gender,
            creditCard: creds.creditCard,
            bio: creds.bio)
    }

    private func addRegData() {
        rootView.enteredText = { [weak self] userData in
            guard let userData else { return }
            self?.regCredentials = RegCredentials(
                userId: userData.userId,
                login: userData.login,
                password: userData.password,
                email: userData.email,
                gender: userData.gender,
                creditCard: userData.creditCard,
                bio: userData.bio)
        }
    }

    private func nextTextField() {
        rootView.pressedReturn = { [weak self] textField in
            guard let userView = self?.rootView.userView else { return }
            switch textField {
            case userView.userIdTextField:
                userView.loginTextField.becomeFirstResponder()
            case userView.loginTextField:
                userView.passwordTextField.becomeFirstResponder()
            case userView.passwordTextField:
                userView.emailTextField.becomeFirstResponder()
            case userView.emailTextField:
                userView.genderTextField.becomeFirstResponder()
            case userView.genderTextField:
                userView.creditCardTextField.becomeFirstResponder()
            case userView.creditCardTextField:
                userView.bioTextField.becomeFirstResponder()
            case userView.bioTextField:
                userView.bioTextField.resignFirstResponder()
            default: break
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        title = "Register"
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - RegData
struct RegCredentials {
    let userId: Int
    let login: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String

    init?(
        userId: Int,
        login: String,
        password: String,
        email: String,
        gender: String,
        creditCard: String,
        bio: String
    ) {
        guard
            userId > 0,
            !login.isEmpty,
            !password.isEmpty,
            !email.isEmpty,
            !gender.isEmpty,
            !creditCard.isEmpty,
            !bio.isEmpty
        else {
            return nil
        }
        self.userId = userId
        self.login = login
        self.password = password
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
    }
}
