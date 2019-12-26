//
//  Builder.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 12/23/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation

/// Base class for  depenencies.
public class Dependency<T> {

    let parentDependency: T
    init(parentDependency: T) {
        self.parentDependency = parentDependency
    }
}

/// Base class for builders.
public class Builder<T> {
    let dependency: T
    init(dependency: T) {
        self.dependency = dependency
    }
}

/// A common interface for all builders.
public protocol Buildable {

}
