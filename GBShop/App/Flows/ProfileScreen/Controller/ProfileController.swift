//
//  ProfileController.swift
//  GBShop
//
//  Created by Константин on 28.03.2023.
//

import UIKit

final class ProfileController<View: ProfileView>: BaseViewController<View> {
    // MARK: - Properties
    private let editProfile: EditProfileRequestFactory
    
    // MARK: - Construction
    init(requestFactory: RequestFactory) {
        self.editProfile = requestFactory.makeEditProfileRequestFactory()
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
    }

    // MARK: - Functions
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
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
