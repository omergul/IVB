//___FILEHEADER___

import Foundation


protocol ___VARIABLE_productName___Listener {
    // Interface for the interactor's listeners.
    // Most likely, the parent of this interactor will be implementing this protocol.
}

protocol ___VARIABLE_productName___Interactable: ___VARIABLE_productName___ViewControllerListener {
    // Interface for the interactor.
    // Should extend its child interactor listeners as well as its VC listener.
}

class ___VARIABLE_productName___Interactor: ViewableInteractor<___VARIABLE_productName___ViewControllable>, ___VARIABLE_productName___Interactable {

    var listener: ___VARIABLE_productName___Listener?
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
}

// MARK: - ___VARIABLE_productName___ViewControllerListener

extension ___VARIABLE_productName___Interactor: ___VARIABLE_productName___ViewControllerListener {

}
