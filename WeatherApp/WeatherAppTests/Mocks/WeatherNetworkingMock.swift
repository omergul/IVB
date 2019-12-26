//
//  WeatherNetworkingMock.swift
//  WeatherAppTests
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

@testable import WeatherApp

class WeatherNetworkingMock: WeatherNetworking {
    var invokedFetchCityWeather = false
    var invokedFetchCityWeatherCount = 0
    var invokedFetchCityWeatherParameters: (cityId: String, Void)?
    var invokedFetchCityWeatherParametersList = [(cityId: String, Void)]()
    var stubbedFetchCityWeatherCompletionHandlerResult: (Result<CityWeather, Error>, Void)?
    func fetchCityWeather(cityId: String,
    completionHandler: @escaping (Result<CityWeather, Error>) -> Void) {
        invokedFetchCityWeather = true
        invokedFetchCityWeatherCount += 1
        invokedFetchCityWeatherParameters = (cityId, ())
        invokedFetchCityWeatherParametersList.append((cityId, ()))
        if let result = stubbedFetchCityWeatherCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
