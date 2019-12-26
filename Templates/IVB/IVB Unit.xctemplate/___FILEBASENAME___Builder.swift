//___FILEHEADER___

import Foundation

// MARK: - Dependency

protocol ___VARIABLE_productName___ParentDependency {
    // Specify the dependencies from the parent unit
}

protocol ___VARIABLE_productName___Dependency: ___VARIABLE_productName___ParentDependency {
    // Speciy the the dependencies that will be created at this scope
}

class ___VARIABLE_productName___DependencyManager: Dependency<___VARIABLE_productName___ParentDependency>, ___VARIABLE_productName___Dependency {
    // Return the dependencies 
}

// MARK: - Builder

protocol ___VARIABLE_productName___Buildable: Buildable {
    func build() -> ViewableInteractable
}

class ___VARIABLE_productName___Builder: Builder<___VARIABLE_productName___Dependency>, ___VARIABLE_productName___Buildable {
    func build() -> ViewableInteractable {
        let view = ___VARIABLE_productName___ViewController()
        let interactor = ___VARIABLE_productName___Interactor(view)
        view.listener = interactor
        return interactor
    }
}
