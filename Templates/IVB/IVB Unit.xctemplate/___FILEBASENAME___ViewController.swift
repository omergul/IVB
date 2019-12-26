//___FILEHEADER___

import Foundation

protocol ___VARIABLE_productName___ViewControllerListener {
    // Listener interface, should be implemented by the interactor
}

protocol ___VARIABLE_productName___ViewControllable: ViewControllable {
    // Interface for the controller
}

class ___VARIABLE_productName___ViewController: ViewController, ___VARIABLE_productName___ViewControllable {

    var listener: ___VARIABLE_productName___ViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - ___VARIABLE_productName___ViewControllable

}
