//
//  UserView.swift
//  GBShop
//
//  Created by Константин on 27.03.2023.
//

import UIKit

final class UserView: UIView {
    // MARK: - Properties
    var pressedReturn: PressedReturn?
    var enteredText: UserEnteredText?

    private var outputData: UserViewOutputData? {
        guard
            let userId = Int(userIdTextField.text ?? ""),
            userId > 0,
            let login = loginTextField.text,
            !login.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let email = emailTextField.text,
            !email.isEmpty,
            let gender = genderTextField.text,
            !gender.isEmpty,
            let creditCard = creditCardTextField.text,
            !creditCard.isEmpty,
            let bio = bioTextField.text,
            !bio.isEmpty
        else {
            return nil
        }
        return UserViewOutputData(
            userId: userId,
            login: login,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio)
    }
    
    // MARK: - UI Properties
    private(set) lazy var userIdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "UserID"
        textField.keyboardType = .numbersAndPunctuation
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "Login"
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "Gender"
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var creditCardTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.borderStyle = .roundedRect
        textField.placeholder = "Credit card"
        textField.keyboardType = .numbersAndPunctuation
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private(set) lazy var bioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.placeholder = "Bio"
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                userIdTextField,
                loginTextField,
                passwordTextField,
                emailTextField,
                genderTextField,
                creditCardTextField,
                bioTextField
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    private func configureUI() {
        backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension UserView: UITextFieldDelegate {
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pressedReturn?(textField)
        return true
    }
}

// MARK: - UserViewOutputData
struct UserViewOutputData {
    let userId: Int
    let login: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
