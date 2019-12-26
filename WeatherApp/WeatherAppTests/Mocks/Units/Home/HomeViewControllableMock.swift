//
//  HomeViewControllableMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/25/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import UIKit
@testable import WeatherApp

class HomeViewControllableMock: UIViewController, HomeViewControllable {
    var invokedUpdateWithCities = false
    var invokedUpdateWithCitiesCount = 0
    var invokedUpdateWithCitiesParameters: (city: [City], Void)?
    var invokedUpdateWithCitiesParametersList = [(city: [City], Void)]()
    func updateWithCities(_ city: [City]) {
        invokedUpdateWithCities = true
        invokedUpdateWithCitiesCount += 1
        invokedUpdateWithCitiesParameters = (city, ())
        invokedUpdateWithCitiesParametersList.append((city, ()))
    }
    var invokedUpdateTitle = false
    var invokedUpdateTitleCount = 0
    var invokedUpdateTitleParameters: (title: String, Void)?
    var invokedUpdateTitleParametersList = [(title: String, Void)]()
    func updateTitle(_ title: String) {
        invokedUpdateTitle = true
        invokedUpdateTitleCount += 1
        invokedUpdateTitleParameters = (title, ())
        invokedUpdateTitleParametersList.append((title, ()))
    }
}
