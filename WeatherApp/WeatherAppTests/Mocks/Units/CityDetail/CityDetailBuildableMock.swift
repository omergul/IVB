//
//  CityDetailBuildableMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/25/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

@testable import WeatherApp

class CityDetailBuildableMock: CityDetailBuildable {
    var invokedBuild = false
    var invokedBuildCount = 0
    var invokedBuildParameters: (city: City, listener: CityDetailListener)?
    var invokedBuildParametersList = [(city: City, listener: CityDetailListener)]()
    var stubbedBuildResult: ViewableInteractable!
    func build(city: City, listener: CityDetailListener) -> ViewableInteractable {
        invokedBuild = true
        invokedBuildCount += 1
        invokedBuildParameters = (city, listener)
        invokedBuildParametersList.append((city, listener))
        return stubbedBuildResult
    }
}

