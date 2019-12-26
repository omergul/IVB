//
//  HomeInteractor.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import UIKit

protocol HomeListener {
    func logout()
}

protocol HomeInteractable: CityDetailListener, HomeViewControllerListener {

}

class HomeInteractor: ViewableInteractor<HomeViewControllable>, HomeInteractable {

    var listener: HomeListener?

    private let activeUser: User
    private let cityDetailBuilder: CityDetailBuildable

    private var cityDetailInteractor: ViewableInteractable?

    init(_ viewController: HomeViewControllable,
         activeUser: User,
         cityDetailBuilder: CityDetailBuildable) {
        self.activeUser = activeUser
        self.cityDetailBuilder = cityDetailBuilder
        super.init(viewController)
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        let title = "Hi " + activeUser.name
        viewController.updateTitle(title)

        let cities = getCities()
        viewController.updateWithCities(cities)
    }

    // MARK: - Private

    func getCities() -> [City] {
        return [
            City(name: "San Francisco", id: "5391959"),
            City(name: "New York City", id: "5128638"),
            City(name: "London", id: "2643743"),
            City(name: "Beijing", id: "1816670"),
            City(name: "Sydney", id: "2147714")
        ]
    }
}

extension HomeInteractor: CityDetailListener {

    func dismissCityDetail() {
        guard let interactor = cityDetailInteractor else {
            return
        }
        detach(interactor: interactor) { parentView in
            parentView.dismiss(animated: true, completion: nil)
        }
    }
}

extension HomeInteractor: HomeViewControllerListener {

    func didTapOnCity(_ city: City) {
        let cityDetailInteractor = cityDetailBuilder.build(city: city, listener: self)
        self.cityDetailInteractor = cityDetailInteractor
        attach(interactor: cityDetailInteractor) { parentView in
            let navVC = UINavigationController(rootViewController: cityDetailInteractor.view)
            parentView.navigationController?.present(navVC, animated: true, completion: nil)
        }
    }

    func didTapLogout() {
        listener?.logout()
    }
}
