//
//  ViewControllerModel.swift
//  MVP Project
//
//  Created by admin on 29.03.2023.
//

import Foundation

struct LoginModel {
    
    var email: String = ""
    var password: String = ""
    var isPasswordHidden: Bool = true
    
    // Возвращается title для Alert и его message
    func onLoginButtonClicked() -> (String, String) {
        if(areNotEmptyTextFields() == false) {
            return ("Error", "You have not provided all required information. Please fill all the text fields")
        }
        if(isValidEmail() == false) {
            return ("Error", "Your email is not conforming to default email standards")
        }
        return ("Success", "You've moved to the Main Screen")
    }
    
    // MARK: Text fields validation
    func areNotEmptyTextFields() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    func isValidEmail() -> Bool {
        let emailRegex = "^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email.lowercased())
    }
}
