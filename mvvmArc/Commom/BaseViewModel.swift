//
//  BaseViewModel.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 07/05/21.
//

import Foundation
import Combine

class SimpleModel<T, A> {
    weak var controller: BaseController<T, A>?
    // Devem ser sobrescritos
    func setState(state: T) {
        fatalError("This method should be overridden")
    }
}

class BaseViewModel<T, A, B>: SimpleModel<T, B> {
    
    private(set) var eventListener: AnyCancellable?
    var coordinator: BaseCoordinator<T>?
    
    func setupEventListener(publisher: PassthroughSubject<A, Never>) {
        eventListener = publisher.sink(
            receiveValue: { self.handleScreenEvent($0) }
        )
    }
    
    var observable: Observable<String> = Observable("")
    private(set) var viewModelStatePublisher = PassthroughSubject<T, Never>()

    // Devem ser sobrescritos
    func handleScreenEvent(_ event: A) {
        fatalError("This method should be overridden")
    }
}
