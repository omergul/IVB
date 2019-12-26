//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/27/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import UIKit

struct CityDetailViewModel {
    let navigationItemTitle: String
    let headline: String
    let description: String
}

protocol CityDetailViewControllerListener {
    func didTapClose()
}

protocol CityDetailViewControllable: ViewControllable {
    func update(_ viewModel: CityDetailViewModel)
}

class CityDetailViewController: ViewController, CityDetailViewControllable {

    var listener: CityDetailViewControllerListener?

    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 56)
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 24)
        return label
    }()
    private lazy var closeButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Close",
                               style: UIBarButtonItem.Style.plain,
                               target: self,
                               action: #selector(CityDetailViewController.close(sender:)))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(headlineLabel)
        headlineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY).offset(-20)
        }

        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY)
        }

        navigationItem.rightBarButtonItem = closeButton
    }

    @objc func close(sender: UIBarButtonItem) {
        listener?.didTapClose()
    }

    // MARK: - CityDetailViewControllable

    func update(_ viewModel: CityDetailViewModel) {
        navigationItem.title = viewModel.navigationItemTitle
        headlineLabel.text = viewModel.headline
        descriptionLabel.text = viewModel.description
    }
}
