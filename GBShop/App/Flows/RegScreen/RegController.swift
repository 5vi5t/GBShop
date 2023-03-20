//
//  RegController.swift
//  GBShop
//
//  Created by Константин on 19.03.2023.
//

import UIKit

class RegController: UIViewController {
    // MARK: - Properties
    var regView: RegView {
        guard let view = view as? RegView else {
            return RegView()
        }
        return view
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = RegView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTextFieldDelegates()
        addTap()
    }

    // MARK: - Functions
    private func setupUI() {
        view.backgroundColor = .white
    }

    private func addTextFieldDelegates() {
        regView.loginTextField.delegate = self
        regView.passwordTextField.delegate = self
        regView.emailTextField.delegate = self
        regView.genderTextField.delegate = self
        regView.creditCardTextField.delegate = self
        regView.bioTextField.delegate = self
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
