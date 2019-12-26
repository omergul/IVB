//
//  HomeBuilder.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

// MARK: - Dependency

protocol HomeParentDependency {

}

protocol HomeDependency: HomeParentDependency, CityDetailParentDependency {
    var cityDetailBuilder: CityDetailBuildable { get }
}

class HomeDependencyManager: Dependency<HomeParentDependency>, HomeDependency {
    var cityDetailBuilder: CityDetailBuildable {
        let dependency = CityDetailDependencyManager(parentDependency: self)
        return CityDetailBuilder(dependency: dependency)
    }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(listener: HomeListener, activeUser: User) -> ViewableInteractable
}

class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    func build(listener: HomeListener, activeUser: User) -> ViewableInteractable {
        let view = HomeViewController()
        let interactor = HomeInteractor(view,
                                        activeUser: activeUser,
                                        cityDetailBuilder: dependency.cityDetailBuilder)
        interactor.listener = listener
        view.listener = interactor
        return interactor
    }
}
