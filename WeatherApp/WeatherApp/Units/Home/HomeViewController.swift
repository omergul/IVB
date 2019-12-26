//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import UIKit
import SnapKit

protocol HomeViewControllerListener {
    func didTapOnCity(_ city: City)
    func didTapLogout()
}

protocol HomeViewControllable: ViewControllable {
    func updateWithCities(_ city: [City])
    func updateTitle(_ title: String)
}

class HomeViewController: ViewController {

    var listener: HomeViewControllerListener?

    private var cities = [City]()

    private let cellIdentifier = "CityCell"

    private lazy var logoutButon: UIBarButtonItem = {
        return UIBarButtonItem(title: "Logout",
                               style: UIBarButtonItem.Style.plain,
                               target: self,
                               action: #selector(HomeViewController.logout(sender:)))
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = logoutButon

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func logout(sender: UIBarButtonItem) {
        listener?.didTapLogout()
    }
}

extension HomeViewController: HomeViewControllable {

    func updateWithCities(_ cities: [City]) {
        self.cities = cities
        tableView.reloadData()
    }

    func updateTitle(_ title: String) {
        navigationItem.title = title
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        listener?.didTapOnCity(city)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
