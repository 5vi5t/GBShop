//
//  ShowcaseCollectionView.swift
//  OnlineShop
//
//  Created by Константин on 07.04.2023.
//

import UIKit

final class ShowcaseCollectionView: UICollectionView {
    // MARK: - Properties
    private enum Section {
        case all
    }

    private lazy var diffableDataSource = makeDiffableDataSource()

    // MARK: - Construction
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function
    func update(with data: [ShowcaseCellInputData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ShowcaseCellInputData>()
        snapshot.appendSections([.all])
        snapshot.appendItems(data)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Private function
    private func setup() {
        register(ShowcaseCell.self, forCellWithReuseIdentifier: ShowcaseCell.identifier)
        backgroundColor = .white
        setupLayout()
    }

    private func makeDiffableDataSource() -> UICollectionViewDiffableDataSource<Section, ShowcaseCellInputData> {
        let dataSource = UICollectionViewDiffableDataSource<Section, ShowcaseCellInputData>(
            collectionView: self) { collectionView, indexPath, data -> UICollectionViewCell in
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShowcaseCell.identifier,
                    for: indexPath
                ) as? ShowcaseCell
            else {
                return ShowcaseCell()
            }
            cell.update(with: data)
            return cell
        }
        return dataSource
    }

    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        collectionViewLayout = layout
    }
}
