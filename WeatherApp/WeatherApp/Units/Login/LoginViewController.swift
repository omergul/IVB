//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 12/24/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewControllerListener {
    func didTapGo(name: String)
}

protocol LoginViewControllable: ViewControllable {
    // Interface for the controller
}

class LoginViewController: ViewController, LoginViewControllable {

    var listener: LoginViewControllerListener?

    private var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.returnKeyType = .go
        textField.textAlignment = .center
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        navigationItem.title = "Login"

        view.addSubview(textField)
        textField.delegate = self
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.height.equalTo(50)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        textField.becomeFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let name = textField.text, name.count > 0 else {
            return false
        }

        listener?.didTapGo(name: name)
        return true
    }
}
