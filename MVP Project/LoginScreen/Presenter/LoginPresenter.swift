//
//  ViewControllerPresenter.swift
//  MVP Project
//
//  Created by admin on 29.03.2023.
//

import Foundation
import UIKit

class LoginPresenter {
    private var model = LoginModel()
    weak var viewController: (ViewControllerProtocol)?
    
    func updateEmail(email: String) {
        self.model.email = email
    }
    func updatePassword(password: String) {
        self.model.password = password
    }
    func goToMain() {
        print(model.email, model.password)
        let passResult = model.onLoginButtonClicked()
        self.displayAlert(title: passResult.0, message: passResult.1)
    }
    func goToRegister() {
        self.displayAlert(title: "Success", message: "You've moved to the Register Screen")
    }
    func getEmail() -> String {
        return model.email
    }
    func getPassword() -> String {
        return model.password
    }
    func togglePasswordVisibility() {
        model.isPasswordHidden.toggle()
        viewController?.setPasswordVisibility(isVisible: model.isPasswordHidden)
        viewController?.setPasswordIcon(isVisible: model.isPasswordHidden)
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController?.displayAlert(alertController)
    }
    
}
