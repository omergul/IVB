//
//  LoginInteractorTests.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/25/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherApp

class LoginInteractorTests: XCTestCase {
    
    private var interactor: LoginInteractor!
    
    private let loginViewControllerMock = LoginViewControllableMock()
    private let loginListenerMock = LoginListenerMock()

    override func setUp() {
        interactor = LoginInteractor(loginViewControllerMock)
        interactor.listener = loginListenerMock
    }
    
    func test_didTapGo_callsListener() {
        XCTAssertEqual(loginListenerMock.invokedDidCompleteLoginCount, 0)
        
        interactor.didTapGo(name: "test")
        
        XCTAssertEqual(loginListenerMock.invokedDidCompleteLoginCount, 1)
    }
}
