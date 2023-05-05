//
//  ZeroView.swift
//  OnlineShop
//
//  Created by Константин on 10.04.2023.
//

import UIKit

final class ZeroView: UIView {
    // MARK: - Properties
    private var onTryAgain: VoidClosure?
    private let containerHorizontalInset: CGFloat = 20

    // MARK: - UIProperties
    private let emojiLabel = UILabel()
    private let messageLabel = UILabel()
    private let tryAgainButton = UIButton(type: .system)
    private let containerView = UIStackView()

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func update(with data: ErrorInputData) {
        emojiLabel.text = String(data.emoji)
        messageLabel.text = data.message
        onTryAgain = data.onTryAgain
        tryAgainButton.isHidden = data.onTryAgain == nil
    }

    // MARK: - Private functions
    private func setupUI() {
        backgroundColor = .systemBackground
        setupEmojiLabel()
        setupMessageLabel()
        setupTryAgainButton()
        setupContainerView()
    }

    private func setupEmojiLabel() {
        emojiLabel.font = .systemFont(ofSize: 100)
        emojiLabel.textAlignment = .center
    }

    private func setupMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 26)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = .zero
    }

    private func setupTryAgainButton() {
        tryAgainButton.setTitle("Try again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainTapped), for: .touchUpInside)
    }

    @objc private func tryAgainTapped() {
        onTryAgain?()
    }

    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: containerHorizontalInset),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -containerHorizontalInset),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.distribution = .fill
        containerView.spacing = 30
        containerView.addArrangedSubview(emojiLabel)
        containerView.addArrangedSubview(messageLabel)
        containerView.addArrangedSubview(tryAgainButton)
    }
}
