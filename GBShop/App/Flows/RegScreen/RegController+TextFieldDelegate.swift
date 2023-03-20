//
//  RegController+TextFieldDelegate.swift
//  GBShop
//
//  Created by Константин on 19.03.2023.
//

import UIKit

// MARK: - UITextFieldDelegate
extension RegController: UITextFieldDelegate {
    // MARK: - Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case regView.loginTextField:
            regView.passwordTextField.becomeFirstResponder()
        case regView.passwordTextField:
            regView.emailTextField.becomeFirstResponder()
        case regView.emailTextField:
            regView.genderTextField.becomeFirstResponder()
        case regView.genderTextField:
            regView.creditCardTextField.becomeFirstResponder()
        case regView.creditCardTextField:
            regView.bioTextField.becomeFirstResponder()
        case regView.bioTextField:
            textField.resignFirstResponder()
        default: break
        }
        return true
    }
}
