//
//  CityDetailBuilder.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/27/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

// MARK: - Dependency

protocol CityDetailParentDependency {

}

protocol CityDetailDependency: CityDetailParentDependency {
    var weatherNetwork: WeatherNetworking { get }
}

class CityDetailDependencyManager: Dependency<CityDetailParentDependency>, CityDetailDependency {
    var weatherNetwork: WeatherNetworking {
        return WeatherNetwork()
    }
}

// MARK: - Builder

protocol CityDetailBuildable: Buildable {
    func build(city: City, listener: CityDetailListener) -> ViewableInteractable
}

class CityDetailBuilder: Builder<CityDetailDependency>, CityDetailBuildable {

    func build(city: City, listener: CityDetailListener) -> ViewableInteractable {
        let view = CityDetailViewController()
        let interactor = CityDetailInteractor(view,
                                              city: city,
                                              weatherNetwork: dependency.weatherNetwork)
        interactor.listener = listener
        view.listener = interactor
        return interactor
    }
}
