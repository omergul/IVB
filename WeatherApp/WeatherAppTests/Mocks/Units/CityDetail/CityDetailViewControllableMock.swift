//
//  CityDetailViewControllableMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

@testable import WeatherApp

class CityDetailViewControllableMock: CityDetailViewControllable {
    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (viewModel: CityDetailViewModel, Void)?
    var invokedUpdateParametersList = [(viewModel: CityDetailViewModel, Void)]()
    func update(_ viewModel: CityDetailViewModel) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (viewModel, ())
        invokedUpdateParametersList.append((viewModel, ()))
    }
}
