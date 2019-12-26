//
//  CityDetailInteractorTests.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import XCTest
@testable import WeatherApp

class CityDetailInteractorTests: XCTestCase {
    
    private var interactor: CityDetailInteractor!
    
    private let cityDetailViewControllerMock = CityDetailViewControllableMock()
    private let weatherNetworkMock = WeatherNetworkingMock()
    private let city = City(name: "testName", id: "testId")
    private let cityWeather = CityWeather(temperature: 9.0, description: "test")

    override func setUp() {
        
        interactor = CityDetailInteractor(cityDetailViewControllerMock,
                                          city: city,
                                          weatherNetwork: weatherNetworkMock)
        
        weatherNetworkMock.stubbedFetchCityWeatherCompletionHandlerResult = (Result<CityWeather, Error>.success(cityWeather), ())
    }
    
    func test_didBecomeActive_callsWeatherNetwork_updatesView() {
        XCTAssertEqual(weatherNetworkMock.invokedFetchCityWeatherCount, 0)
        XCTAssertEqual(cityDetailViewControllerMock.invokedUpdateCount, 0)
        
        interactor.didBecomeActive()
        
        XCTAssertEqual(weatherNetworkMock.invokedFetchCityWeatherCount, 1)
        XCTAssertEqual(cityDetailViewControllerMock.invokedUpdateCount, 1)
        
        if let params = weatherNetworkMock.invokedFetchCityWeatherParameters {
            XCTAssertEqual(params.cityId, city.id)
        }
    }
}
