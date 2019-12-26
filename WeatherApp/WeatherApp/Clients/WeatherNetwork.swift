//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/27/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import Alamofire

protocol WeatherNetworking {
    func fetchCityWeather(cityId: String,
                          completionHandler: @escaping (Result<CityWeather, Error>) -> Void)
}

struct GetWeatherParams: Encodable {
    let id: String
    let APPID: String
    let units: String
}

enum WeatherNetworkError: Error {
    case invalidPayload
}

class WeatherNetwork: WeatherNetworking {

    // Create your own apikey from https://openweathermap.org/api
    private let apiKey = ""
    private let url = "http://api.openweathermap.org/data/2.5/weather"

    // MARK: - WeatherNetworking

    public func fetchCityWeather(cityId: String, completionHandler: @escaping (Result<CityWeather, Error>) -> Void) {
        fetchCityWeatherJson(cityId: cityId) { response in
            switch response.result {
            case let .success(value):
                guard let json = value as? NSDictionary else {
                    completionHandler(.failure(WeatherNetworkError.invalidPayload))
                    return
                }
                let weather = self.createCityWeather(json: json)
                completionHandler(.success(weather))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }

    private func fetchCityWeatherJson(cityId: String,
                                      completionHandler: @escaping (DataResponse<Any, AFError>) -> Void) {
        let params = GetWeatherParams(id: cityId,
                                      APPID: apiKey,
                                      units: "imperial")

        AF.request(url, method: .get, parameters: params)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
            .responseJSON(completionHandler: completionHandler)
    }

    private func createCityWeather(json: NSDictionary) -> CityWeather {
        let temp = json.value(forKeyPath: "main.temp") as? Double ?? 0

        var description = ""
        if let weatherList = json.value(forKeyPath: "weather") as? NSArray,
            let weather = weatherList.lastObject as? NSDictionary {
            description = (weather.value(forKey: "description") as? String) ?? ""
        }

        return CityWeather(temperature: temp, description: description)
    }
}
