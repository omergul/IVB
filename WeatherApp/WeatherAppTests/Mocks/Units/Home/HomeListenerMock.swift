//
//  HomeListenerMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/25/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

@testable import WeatherApp

class HomeListenerMock: HomeListener {
    var invokedLogout = false
    var invokedLogoutCount = 0
    func logout() {
        invokedLogout = true
        invokedLogoutCount += 1
    }
}
