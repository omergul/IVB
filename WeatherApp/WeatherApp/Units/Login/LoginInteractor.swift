//
//  LoginInteractor.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 12/24/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

protocol LoginListener {
    func didCompleteLogin(user: User)
}

protocol LoginInteractable: LoginViewControllerListener {

}

class LoginInteractor: ViewableInteractor<LoginViewControllable>, LoginInteractable {

    var listener: LoginListener?

    override func didBecomeActive() {
        super.didBecomeActive()
    }
}

// MARK: - LoginViewControllerListener

extension LoginInteractor: LoginViewControllerListener {

    func didTapGo(name: String) {
        let user = User(name: name)
        listener?.didCompleteLogin(user: user)
    }
}
