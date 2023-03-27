//
//  RegViewImpl.swift
//  GBShop
//
//  Created by Константин on 19.03.2023.
//

import UIKit


// MARK: - RegView
protocol RegView: UIView {
    var pressedReturn: PressedReturn? { get set }
    var enteredText: UserEnteredText? { get set }
    var userView: UserView { get }
}

// MARK: - RegViewImpl
class RegViewImpl: UIView, RegView {
    // MARK: - Properties
    var pressedReturn: PressedReturn?
    var enteredText: UserEnteredText?

    // MARK: - UI Properties
    private(set) lazy var userView: UserView = {
        let view = UserView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                userView,
                signUpButton
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
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    private func setup() {
        userView.pressedReturn = { [weak self] textField in
            self?.pressedReturn?(textField)
        }
        userView.enteredText = { [weak self] userData in
            self?.enteredText?(userData)
        }
        configureUI()
    }
    private func configureUI() {
        backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints() {
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}
