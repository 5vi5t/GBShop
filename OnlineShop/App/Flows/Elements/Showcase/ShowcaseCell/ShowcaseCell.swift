//
//  ShowcaseCell.swift
//  OnlineShop
//
//  Created by Константин on 06.04.2023.
//

import UIKit

final class ShowcaseCell: UICollectionViewCell {
    // MARK: - Static properties
    static let identifier = String(describing: ShowcaseCell.self)

    // MARK: - Properties
    private let images = (
        placeholder: UIImage(systemName: "photo"),
        noPicture: UIImage(systemName: "rectangle.slash")
    )

    // MARK: - UI Properties
    private let pictureView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func update(with inputData: ShowcaseCellInputData) {
        if inputData.pictureUrl != nil {
            pictureView.image = images.placeholder
        } else {
            pictureView.image = images.noPicture
        }
        nameLabel.text = inputData.name
        priceLabel.text = inputData.price
    }

    // MARK: - Private functions
    private func setup() {
        setupPictureView()
        setupNameLabel()
        setupPriceLabel()
    }

    private func setupPictureView() {
        pictureView.image = images.placeholder
        pictureView.contentMode = .scaleAspectFit
        pictureView.clipsToBounds = true
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pictureView)

        NSLayoutConstraint.activate([
            pictureView.widthAnchor.constraint(equalToConstant: 150),
            pictureView.heightAnchor.constraint(equalToConstant: 150),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.numberOfLines = .zero
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    private func setupPriceLabel() {
        priceLabel.textColor = .systemRed
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.numberOfLines = .zero
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - ShowcaseCellInputData
struct ShowcaseCellInputData: Hashable {
    let name: String
    let price: String
    let pictureUrl: String?
}
