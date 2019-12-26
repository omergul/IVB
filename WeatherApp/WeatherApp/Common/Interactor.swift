//
//  Interactor.swift
//  WeatherApp
//
//  Created by Ömer Faruk Gül on 10/13/19.
//  Copyright © 2019 Omer Faruk Gul. All rights reserved.
//

import Foundation
import UIKit

public protocol Interactable: class {
    var uuid: String { get }
    func willBecomeActive()
    func didBecomeActive()
    func willResignActive()
}

public protocol ViewableInteractable: Interactable {
    var view: UIViewController { get }
}

/// Base class for interactors.
open class Interactor: Interactable {

    public let uuid: String = UUID().uuidString

    /// Called just before the interactor becomes active.
    open func willBecomeActive() {}

    /// Called just after the interactor has become active.
    open func didBecomeActive() {}

    /// Called just before the interactor is removed from the app tree.
    open func willResignActive() {}

    fileprivate var childInteractors = [AnyInteractor]()

    /// Attach an interactor.
    /// - Parameter interactor: An interactable.
    public func attach(interactor: Interactable) {
        interactor.willBecomeActive()
        childInteractors.append(AnyInteractor(interactor: interactor))
        interactor.didBecomeActive()
    }

    /// Count of child interactors
    public var childInteractorsCount: Int {
        return childInteractors.count
    }

    public init() {}
}

/// Base class for viewable interactors.
open class ViewableInteractor<T>: Interactor, ViewableInteractable {
    public var viewController: T

    /// Associated view controller of the ViewableInteractor.
    public var view: UIViewController {
        guard let view = viewController as? UIViewController else {
            fatalError("ViewController is not a UIViewController")
        }
        return view
    }

    /// Attaches an interactor.
    /// - Parameter interactor: A ViewableInteractable
    /// - Parameter viewHandler: Block for handling the views. Block receives the parent view conrtroller as a param.
    public func attach(interactor: ViewableInteractable,
                       viewHandler: (_ parentViewController: UIViewController) -> Void) {
        interactor.willBecomeActive()
        childInteractors.append(AnyInteractor(interactor: interactor))
        viewHandler(view)
        interactor.didBecomeActive()
    }

    /// Detaches an already attached interactor.
    /// - Parameter interactor: A ViewableInteractable
    /// - Parameter viewHandler: Block for handling the views. Block receives the parent view conrtroller as a param.
    public func detach(interactor: ViewableInteractable,
                       viewHandler: (_ parentViewController: UIViewController) -> Void) {
        let anyInteractor = AnyInteractor(interactor: interactor)
        guard let index = childInteractors.firstIndex(of: anyInteractor) else {
            return
        }
        childInteractors.remove(at: index)

        interactor.willResignActive()
        viewHandler(view)
    }

    /// Initialize a ViewableInteractor.
    /// - Parameter viewController: A view controller
    public init(_ viewController: T) {
        self.viewController = viewController
    }
}

/// Struct for type-erasing for Interactor.
struct AnyInteractor: Equatable {

    private let interactor: Interactable

    init(interactor: Interactable) {
        self.interactor = interactor
    }

    static func == (lhs: AnyInteractor, rhs: AnyInteractor) -> Bool {
        return lhs.interactor.uuid == rhs.interactor.uuid
    }
}
