//
//  ErrorView.swift
//  OnlineShop
//
//  Created by Константин on 10.04.2023.
//

import UIKit

final class ErrorView: UIView {
    private var onTryAgain: VoidClosure?

    private let stackContainer = UIStackView()
    private let messageLabel = UILabel()
    private let tryAgainButton = UIButton(type: .system)

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    // MARK: - Functions
    func update(with data: ErrorInputData) {
        messageLabel.text = "\(String(data.emoji)) \(data.message)"
        onTryAgain = data.onTryAgain
        tryAgainButton.isHidden = data.onTryAgain == nil
    }

    // MARK: - Private functions
    @objc private func tryAgainTapped() {
        onTryAgain?()
    }

    private func setupStackContainer() {
        stackContainer.axis = .vertical
        stackContainer.distribution = .fill
        stackContainer.alignment = .fill
        stackContainer.spacing = 0
        stackContainer.isLayoutMarginsRelativeArrangement = true
        stackContainer.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 34,
            trailing: 16
        )

        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        
        addSubview(backgroundView)
        backgroundView.addSubview(stackContainer)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackContainer.topAnchor.constraint(equalTo: topAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupMessageLabel() {
        messageLabel.textColor = .red
        messageLabel.font = .preferredFont(forTextStyle: .callout)

        stackContainer.addArrangedSubview(messageLabel)
    }

    private func setupTryAgainButton() {
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)

        stackContainer.addArrangedSubview(tryAgainButton)
    }

    private func setup() {
        backgroundColor = .clear

        setupStackContainer()
        setupMessageLabel()
        setupTryAgainButton()
    }
}

// MARK: - ErrorInputData
struct ErrorInputData {
    let emoji: Character
    let message: String
    let onTryAgain: VoidClosure?
}

extension ErrorInputData {
    static let networkConnectionLost = ErrorInputData(
        emoji: "📡",
        message: "Network Connection Lost. Please check your internet connection and try again.",
        onTryAgain: nil
    )
    static let serverError = ErrorInputData(
        emoji: "🛠",
        message: "Internal Server Error. Please try again later or contact customer support.",
        onTryAgain: nil
    )
    static let applicationError = ErrorInputData(
        emoji: "🙈",
        message: "Developer mistake. Please try turning it off and on again",
        onTryAgain: nil
    )
}
