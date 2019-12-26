//
//  HomeInteractorTests.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import XCTest
@testable import WeatherApp

class HomeInteractorTests: XCTestCase {
    
    private var interactor: HomeInteractor!
    
    private let homeViewControllerMock = HomeViewControllableMock()
    private let homeListenerMock = HomeListenerMock()
    private let cityDetailBuilderMock = CityDetailBuildableMock()
    private let user = User(name: "test")

    override func setUp() {
        let interactableMock = ViewableInteractableMock()
        interactableMock.stubbedView = UIViewController()
        
        cityDetailBuilderMock.stubbedBuildResult = interactableMock
        interactor = HomeInteractor(homeViewControllerMock, activeUser: user, cityDetailBuilder: cityDetailBuilderMock)
        interactor.listener = homeListenerMock
    }
    
    func test_didBecomeActive_updatesView() {
        XCTAssertEqual(homeViewControllerMock.invokedUpdateTitleCount, 0)
        XCTAssertEqual(homeViewControllerMock.invokedUpdateWithCitiesCount, 0)
        
        interactor.didBecomeActive()
        
        XCTAssertEqual(homeViewControllerMock.invokedUpdateTitleCount, 1)
        XCTAssertEqual(homeViewControllerMock.invokedUpdateWithCitiesCount, 1)
    }
    
    func test_didTapOnCity_callsCityDetailBuilder() {
        XCTAssertEqual(cityDetailBuilderMock.invokedBuildCount, 0)
        
        interactor.didBecomeActive()
        
        let city = City(name: "test", id: "test")
        interactor.didTapOnCity(city)
        
        XCTAssertEqual(cityDetailBuilderMock.invokedBuildCount, 1)
    }
    
    // MARK: - HomeViewControllerListener tests
    
    func test_dismissCityDetail_detachesCityDetailInteractor() {
        interactor.didBecomeActive()
        
        let city = City(name: "test", id: "test")
        interactor.didTapOnCity(city)
        
        XCTAssertEqual(interactor.childInteractorsCount, 1)
        
        interactor.dismissCityDetail()
        
        XCTAssertEqual(interactor.childInteractorsCount, 0)
    }
    
    func test_didTapLogout_callsListener() {
        interactor.didBecomeActive()
        
        XCTAssertEqual(homeListenerMock.invokedLogoutCount, 0)
        
        interactor.didTapLogout()
        
        XCTAssertEqual(homeListenerMock.invokedLogoutCount, 1)
    }
}
