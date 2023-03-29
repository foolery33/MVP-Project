//
//  ViewController.swift
//  MVP Project
//
//  Created by admin on 29.03.2023.
//

import UIKit
import SnapKit


protocol TextFieldsUpdatable: AnyObject {
    func updateEmail(_ textField: UITextField) -> Void
    func updatePassword(_ textField: UITextField) -> Void
}
protocol TextFieldsTextGettable: AnyObject {
    func getEmail() -> String
    func getPassword() -> String
}
protocol AlertDisplayable: AnyObject {
    func displayAlert(_ akertController: UIAlertController)
}
protocol BetweenScreenMovable: AnyObject {
    func goToMain()
    func goToRegister()
}
protocol PasswordVisibilityControllable: AnyObject {
    func togglePasswordVisibility()
    func setPasswordVisibility(isVisible: Bool)
    func setPasswordIcon(isVisible: Bool)
}

// Общий протокол для того, чтобы в презентере указать тип UIViewController -  ViewControllerProtocol
protocol ViewControllerProtocol: AnyObject, TextFieldsUpdatable, TextFieldsTextGettable, AlertDisplayable, BetweenScreenMovable, PasswordVisibilityControllable {
}

class LoginViewController: UIViewController, ViewControllerProtocol {
    
    let presenter = LoginPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private enum Paddings {
        static let betweenTopAndLogo = 132.0
        static let defaultPadding = 16.0
        static let betweenLogoAndEmail = 104.0
        static let betweenPasswordAndLogin = 156.0
        static let betweenBottomAndRegister = 44.0
    }

    private func setupSubviews() {
        setupLogo()
        setupTextFieldsStackView()
        setupButtonsStackView()
    }
    
    // MARK: - Logotype setup
    
    private lazy var logotype: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "LogoWithName")!
        return logo
    }()
    private func setupLogo() {
        view.addSubview(logotype)
        logotype.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top).offset(Paddings.betweenTopAndLogo)
            make.centerX.equalTo(view)
            presenter.viewController = self
        }
    }
    
    // MARK: - TextField's StackView setup
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Paddings.defaultPadding
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        return stackView
    }()
    private func setupTextFieldsStackView() {
        view.addSubview(textFieldsStackView)
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logotype.snp.bottom).offset(Paddings.betweenLogoAndEmail)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: - Email setup
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()

        textField.text = getPassword()
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.red
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        textField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        textField.addTarget(self, action: #selector(updateEmail(_:)), for: .editingChanged)
        
        return textField
    }()
    // MARK: - Password setup
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()

        textField.text = getPassword()
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true

        textField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.rightView = passwordEye
        textField.rightViewMode = .always
        
        textField.addTarget(self, action: #selector(updatePassword(_:)), for: .editingChanged)
        
        return textField
    }()
    private lazy var passwordEye: UIButton = {
        let eye = UIButton(type: .custom)
        eye.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eye.setImage(UIImage(systemName: "eye"), for: .selected)
        eye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eye
    }()
    
    // MARK: - Button's StackView setup
    
    private lazy var buttonsStackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .vertical
        myStackView.spacing = Paddings.defaultPadding
        myStackView.addArrangedSubview(loginButton)
        myStackView.addArrangedSubview(registerButton)
        return myStackView
    }()
    private func setupButtonsStackView() {
        view.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Paddings.betweenBottomAndRegister)
            make.leading.trailing.equalToSuperview().inset(Paddings.defaultPadding)
        }
    }
    
    // MARK: - Login setup
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.backgroundColor = UIColor.red.cgColor
        button.setTitle("Войти", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Register setup
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.backgroundColor = UIColor.red.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 0, bottom: 13, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return button
    }()
    
}

// MARK: - AlertDisplayable

extension LoginViewController: AlertDisplayable {
    func displayAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TextFieldsUpdatable

extension LoginViewController: TextFieldsUpdatable {
    @objc func updateEmail(_ textField: UITextField) {
        presenter.updateEmail(email: textField.text ?? "")
    }
    @objc func updatePassword(_ textField: UITextField) {
        presenter.updatePassword(password: textField.text ?? "")
    }
}

// MARK: - TextFieldsTextGettable

extension LoginViewController: TextFieldsTextGettable {
    func getEmail() -> String {
        return presenter.getEmail()
    }
    func getPassword() -> String {
        return presenter.getPassword()
    }
}

// MARK: - BetweenScreenMovable

extension LoginViewController: BetweenScreenMovable {
    @objc func goToMain() {
        presenter.goToMain()
    }
    @objc func goToRegister() {
        presenter.goToRegister()
    }
}

// MARK: - PasswordVisibilityControllable

extension LoginViewController: PasswordVisibilityControllable {
    @objc func togglePasswordVisibility() {
        presenter.togglePasswordVisibility()
    }
    func setPasswordVisibility(isVisible: Bool) {
        passwordTextField.isSecureTextEntry = isVisible
    }
    func setPasswordIcon(isVisible: Bool) {
        passwordEye.isSelected = isVisible
    }
}
