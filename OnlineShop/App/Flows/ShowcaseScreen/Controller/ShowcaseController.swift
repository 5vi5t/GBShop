//
//  ShowcaseController.swift
//  OnlineShop
//
//  Created by Константин on 06.04.2023.
//

import UIKit

final class ShowcaseController<View: ShowcaseView>: BaseViewController<View> {
    // MARK: - Properties
    private let getGoodsList: GetGoodsListRequestFactory
    private var products: [Product] = []

    // MARK: - Construction
    init(requestFactory: RequestFactory) {
        self.getGoodsList = requestFactory.makeGetGoodsListRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCatalogData()
    }

    // MARK: - Functions
    private func getCatalogData() {
        getGoodsList.getCatalogData(pageNumber: 1, categoryId: 1) { [weak self] response in
            guard let self else { return }
            let viewInputData: ShowcaseScreenViewInputData
            switch response.result {
            case .success(let result):
                switch result.result {
                case 0:
                    self.products = self.products
                    viewInputData = self.makeShowcaseScreenViewInputData(nil, error: ErrorInputData.applicationError)
                case 1:
                    if let products = result.products {
                        self.products += products
                    }
                    
                    viewInputData = self.makeShowcaseScreenViewInputData(result, error: nil)
                default:
                    viewInputData = self.makeShowcaseScreenViewInputData(nil, error: ErrorInputData.serverError)
                }
            case .failure:
                viewInputData = self.makeShowcaseScreenViewInputData(nil, error: ErrorInputData.serverError)
            }
            DispatchQueue.main.async {
                self.rootView.update(with: viewInputData)
            }
        }
    }

    private func makeShowcaseScreenViewInputData(_ catalogData: CatalogDataResult?, error: ErrorInputData?) -> ShowcaseScreenViewInputData {
        let products = catalogData?.products?.compactMap { makeShowcaseCellInputData(from: $0) } ?? []

        let zeroError: ErrorInputData?
        let errorMessage: ErrorInputData?

        if products.isEmpty {
            zeroError = error
            errorMessage = nil
        } else {
            zeroError = nil
            errorMessage = error
        }

        return ShowcaseScreenViewInputData(
            products: products,
            zeroError: zeroError,
            errorMessage: errorMessage
        )
    }

    private func makeShowcaseCellInputData(from product: Product) -> ShowcaseCellInputData {
        ShowcaseCellInputData(
            name: product.productName,
            price: "\(String(product.price)) руб.",
            pictureUrl: nil)
    }

    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        title = "Goods list"
    }
}
