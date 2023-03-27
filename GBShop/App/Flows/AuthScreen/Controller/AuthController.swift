//
//  AuthController.swift
//  GBShop
//
//  Created by Константин on 05.03.2023.
//

import UIKit

final class AuthController<View: AuthView>: BaseViewController<View> {
    // MARK: - Properties
    private let auth: AuthRequestFactory
    private var loginCredentials: LoginCredentials?

    var onLogin: VoidClosure?
    var pressedSignUpButton: VoidClosure?

    // MARK: - Construction
    init(requestFactory: RequestFactory) {
        self.auth = requestFactory.makeAuthRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signUp()
        addTap()
        nextTextField()
        addLoginData()
        signIn()
    }

    // MARK: - Functions
    private func signUp() {
        rootView.pressedSignUpButton = { [weak self] in
            self?.pressedSignUpButton?()
        }
    }

    private func nextTextField() {
        rootView.pressedReturn = { [weak self] textField in
            switch textField {
            case self?.rootView.loginTextField:
                self?.rootView.passwordTextField.becomeFirstResponder()
            case self?.rootView.passwordTextField:
                self?.rootView.passwordTextField.resignFirstResponder()
            default: break
            }
        }
    }

    private func addLoginData() {
        rootView.enteredText = { [weak self] viewData in
            guard let viewData else { return }
            self?.loginCredentials = LoginCredentials(
                login: viewData.login,
                password: viewData.password)
        }
    }

    private func signIn() {
        rootView.pressedSignInButton = { [weak self] in
            guard let credentials = self?.loginCredentials else { return }
            self?.auth.login(
                username: credentials.login,
                password: credentials.password
            ) { response in
                switch response.result {
                case .success(let result):
                    guard
                        let viewInputData = self?.makeAuthViewInputData(with: result.errorMessage)
                    else { return }
                    DispatchQueue.main.async {
                        self?.rootView.update(with: viewInputData)
                    }
                    if result.result == 1 {
                        self?.onLogin?()
                    }
                case .failure(let error):
                    guard
                        let viewInputData = self?.makeAuthViewInputData(with: error.errorDescription)
                    else { return }
                    DispatchQueue.main.async {
                        self?.rootView.update(with: viewInputData)
                    }
                }
            }
        }
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    private func makeAuthViewInputData(with error: String?) -> AuthViewInputData {
        return AuthViewInputData(errorMessage: error)
    }
}

// MARK: - LoginCredentials
struct LoginCredentials {
    let login: String
    let password: String

    init?(login: String, password: String) {
        guard
            !login.isEmpty,
            !password.isEmpty
        else { return nil }

        self.login = login
        self.password = password
    }
}
