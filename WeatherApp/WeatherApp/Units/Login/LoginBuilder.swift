//
//  LoginBuilder.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 12/24/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

// MARK: - Dependency

protocol LoginParentDependency {
    // Specify the dependencies from the parent unit
}

protocol LoginDependency: LoginParentDependency {
    // Speciy the the dependencies that will be created at this scope
}

class LoginDependencyManager: Dependency<LoginParentDependency>, LoginDependency {

}

// MARK: - Builder

protocol LoginBuildable: Buildable {
    func build(listener: LoginListener) -> ViewableInteractable
}

class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    init(parentDependency: LoginParentDependency) {
        super.init(dependency: LoginDependencyManager(parentDependency: parentDependency))
    }

    func build(listener: LoginListener) -> ViewableInteractable {
        let view = LoginViewController()
        let interactor = LoginInteractor(view)
        interactor.listener = listener
        view.listener = interactor
        return interactor
    }
}
