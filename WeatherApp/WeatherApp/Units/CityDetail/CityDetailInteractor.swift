//
//  CityDetailInteractor.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/27/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

protocol CityDetailListener {
    func dismissCityDetail()
}

protocol CityDetailInteractable: CityDetailViewControllerListener {

}

class CityDetailInteractor: ViewableInteractor<CityDetailViewControllable>, CityDetailInteractable {

    var listener: CityDetailListener?

    private let city: City
    private let weatherNetwork: WeatherNetworking

    init(_ viewController: CityDetailViewControllable, city: City, weatherNetwork: WeatherNetworking) {
        self.city = city
        self.weatherNetwork = weatherNetwork
        super.init(viewController)
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        weatherNetwork.fetchCityWeather(cityId: city.id) { result in
            switch result {
            case let .success(value):
                self.updateView(cityWeather: value)
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: - Private

    private func createViewModel(cityWeather: CityWeather) -> CityDetailViewModel {
        return CityDetailViewModel(navigationItemTitle: city.name,
                                   headline: String(cityWeather.temperature),
                                   description: cityWeather.description)
    }

    private func updateView(cityWeather: CityWeather) {
        let viewModel = createViewModel(cityWeather: cityWeather)
        self.viewController.update(viewModel)
    }
}

extension CityDetailInteractor: CityDetailViewControllerListener {

    func didTapClose() {
        listener?.dismissCityDetail()
    }
}
