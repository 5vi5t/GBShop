//
//  ShowcaseViewImpl.swift
//  OnlineShop
//
//  Created by Константин on 06.04.2023.
//

import UIKit

protocol ShowcaseView: UIView {
    func update(with inputData: ShowcaseScreenViewInputData)
}

final class ShowcaseViewImpl: UIView, ShowcaseView {
    // MARK: - UI Properties
    private let productsView = ShowcaseCollectionView()
    private let zeroView = ZeroView()
    private let errorView = ErrorView()
    private let containerView = UIStackView()

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func update(with inputData: ShowcaseScreenViewInputData) {
        productsView.update(with: inputData.products)

        if let zeroError = inputData.zeroError {
            zeroView.update(with: zeroError)
            zeroView.show()
            productsView.hide()
        } else {
            zeroView.hide()
            productsView.show()
        }

        if let errorMessage = inputData.errorMessage {
            errorView.update(with: errorMessage)
            errorView.show()
        } else {
            errorView.hide()
        }
    }

    // MARK: - Private functions
    private func setup() {
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .white
        setupContainerView()
        [productsView, zeroView, errorView].forEach(containerView.addArrangedSubview)
    }

    private func setupContainerView() {
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.alignment = .fill
        containerView.spacing = 0

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - ShowcaseScreenViewInputData
struct ShowcaseScreenViewInputData {
    let products: [ShowcaseCellInputData]
    let zeroError: ErrorInputData?
    let errorMessage: ErrorInputData?
}
