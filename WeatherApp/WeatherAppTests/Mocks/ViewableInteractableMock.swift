//
//  ViewableInteractableMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import UIKit
@testable import WeatherApp

class ViewableInteractableMock: ViewableInteractable {
    var invokedViewGetter = false
    var invokedViewGetterCount = 0
    var stubbedView: UIViewController!
    var view: UIViewController {
        invokedViewGetter = true
        invokedViewGetterCount += 1
        return stubbedView
    }
    var invokedUuidGetter = false
    var invokedUuidGetterCount = 0
    var stubbedUuid: String! = ""
    var uuid: String {
        invokedUuidGetter = true
        invokedUuidGetterCount += 1
        return stubbedUuid
    }
    var invokedWillBecomeActive = false
    var invokedWillBecomeActiveCount = 0
    func willBecomeActive() {
        invokedWillBecomeActive = true
        invokedWillBecomeActiveCount += 1
    }
    var invokedDidBecomeActive = false
    var invokedDidBecomeActiveCount = 0
    func didBecomeActive() {
        invokedDidBecomeActive = true
        invokedDidBecomeActiveCount += 1
    }
    var invokedWillResignActive = false
    var invokedWillResignActiveCount = 0
    func willResignActive() {
        invokedWillResignActive = true
        invokedWillResignActiveCount += 1
    }
}
