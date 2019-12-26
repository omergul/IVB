//
//  LoginListenerMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/25/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

@testable import WeatherApp

class LoginListenerMock: LoginListener {
    var invokedDidCompleteLogin = false
    var invokedDidCompleteLoginCount = 0
    var invokedDidCompleteLoginParameters: (user: User, Void)?
    var invokedDidCompleteLoginParametersList = [(user: User, Void)]()
    func didCompleteLogin(user: User) {
        invokedDidCompleteLogin = true
        invokedDidCompleteLoginCount += 1
        invokedDidCompleteLoginParameters = (user, ())
        invokedDidCompleteLoginParametersList.append((user, ()))
    }
}
