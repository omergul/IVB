//
//  RootBuilder.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

protocol RootParentDependency {

}

protocol RootDependency: RootParentDependency, HomeParentDependency, LoginParentDependency {
    var loginBuilder: LoginBuildable { get }
    var homeBuilder: HomeBuildable { get }
}

class RootDependencyManager: Dependency<RootParentDependency>, RootDependency {
    var loginBuilder: LoginBuildable {
        let dependency = LoginDependencyManager(parentDependency: self)
        return LoginBuilder(dependency: dependency)
    }

    var homeBuilder: HomeBuildable {
        let dependency = HomeDependencyManager(parentDependency: self)
        return HomeBuilder(dependency: dependency)
    }
}

protocol RootBuildable: Buildable {
    func build() -> ViewableInteractable
}

class RootBuilder: Builder<RootDependency>, RootBuildable {
    func build() -> ViewableInteractable {
        let view = RootViewController()
        return RootInteractor(view, homeBuilder: dependency.homeBuilder, loginBuilder: dependency.loginBuilder)
    }
}
