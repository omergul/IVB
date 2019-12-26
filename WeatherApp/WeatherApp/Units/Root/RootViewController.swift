//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import UIKit

protocol RootViewControllerListener {

}

class RootViewController: ViewController, RootViewControllable {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}
