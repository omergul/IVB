//
//  RootInteractor.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewControllable: ViewControllable {

}

protocol RootInteractable: RootViewControllerListener, LoginListener {

}

class RootInteractor: ViewableInteractor<RootViewControllable>, RootInteractable {

    let homeBuilder: HomeBuildable
    let loginBuilder: LoginBuildable

    var homeInteractor: ViewableInteractable?
    var loginInteractor: ViewableInteractable?

    init(_ viewController: RootViewControllable,
         homeBuilder: HomeBuildable,
         loginBuilder: LoginBuildable) {
        self.homeBuilder = homeBuilder
        self.loginBuilder = loginBuilder
        super.init(viewController)
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        attachLogin()
    }

    // MARK: Private

    private func attachLogin() {
        // build
        let loginInteractor = loginBuilder.build(listener: self)
        self.loginInteractor = loginInteractor

        // attach
        attach(interactor: loginInteractor) { parentView in
            let navigationController = UINavigationController(rootViewController: loginInteractor.view)
            navigationController.modalPresentationStyle = .fullScreen
            parentView.present(navigationController, animated: false, completion: nil)
        }
    }

    private func attachHome(user: User) {
        let homeInteractor = homeBuilder.build(listener: self, activeUser: user)
        self.homeInteractor = homeInteractor

        // attach home interactor
        self.attach(interactor: homeInteractor) { parentView in
            let navigationController = UINavigationController(rootViewController: homeInteractor.view)
            navigationController.modalPresentationStyle = .fullScreen
            parentView.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension RootInteractor: LoginListener {

    func didCompleteLogin(user: User) {
        guard let loginInteractor = loginInteractor else {
            return
        }

        detach(interactor: loginInteractor) { parentView in
            parentView.dismiss(animated: true) {
                // clear login interactor
                self.loginInteractor = nil
            }

            self.attachHome(user: user)
        }
    }
}

extension RootInteractor: HomeListener {

    func logout() {
        guard let homeInteractor = homeInteractor else {
            return
        }

        detach(interactor: homeInteractor) { parentView in
            parentView.dismiss(animated: true) {
                // clear login interactor
                self.homeInteractor = nil
            }

            self.attachLogin()
        }
    }
}
