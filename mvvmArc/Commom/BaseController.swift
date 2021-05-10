//
//  BaseController.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 07/05/21.
//

import Foundation

class BaseController<T, A> {
    private var model: SimpleModel<T, A>?
    
    func handle(action: A) {
        fatalError("This method should be overridden")
    }
}
