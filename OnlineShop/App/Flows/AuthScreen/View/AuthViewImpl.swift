//
//  AuthView.swift
//  OnlineShop
//
//  Created by Константин on 18.03.2023.
//

import UIKit

// MARK: - AuthView
protocol AuthView: UIView {
    var pressedSignInButton: VoidClosure? { get set }
    var pressedSignUpButton: VoidClosure? { get set }
    var pressedReturn: PressedReturn? { get set }
    var enteredText: AuthEnteredText? { get set }
    var loginTextField: UITextField { get }
    var passwordTextField: UITextField { get }

    func update(with inputData: AuthViewInputData)
}

// MARK: - AuthViewImpl
final class AuthViewImpl: UIView, AuthView {
    // MARK: - Properties
    var pressedSignInButton: VoidClosure?
    var pressedSignUpButton: VoidClosure?
    var pressedReturn: PressedReturn?
    var enteredText: AuthEnteredText?

    private var outputData: AuthViewOutputData? {
        guard
            let login = loginTextField.text,
            !login.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty
        else {
            return nil
        }
        return AuthViewOutputData(
            login: login,
            password: password)
    }

    // MARK: - UI Properties
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
        textField.returnKeyType = .done
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        let action = UIAction { [weak self] _ in
            self?.enteredText?(self?.outputData)
        }
        textField.addAction(action, for: .editingChanged)
        return textField
    }()
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.pressedSignInButton?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.pressedSignUpButton?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                loginTextField,
                passwordTextField
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                signInButton,
                signUpButton
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var externalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                textFieldsStackView,
                buttonsStackView
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
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
    func update(with inputData: AuthViewInputData) {
        errorLabel.isHidden = inputData.errorMessage == nil
        errorLabel.text = inputData.errorMessage ?? ""
    }

    // MARK: - Private functions
    private func configureUI() {
        backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints() {
        addSubview(externalStackView)
        addSubview(errorLabel)

        NSLayoutConstraint.activate([
            externalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            externalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            externalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            errorLabel.topAnchor.constraint(equalTo: externalStackView.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewImpl: UITextFieldDelegate {
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pressedReturn?(textField)
        return true
    }
}

// MARK: - AuthViewInputData
struct AuthViewInputData {
    let errorMessage: String?
}

// MARK: - AuthViewOutputData
struct AuthViewOutputData {
    let login: String
    let password: String
}
