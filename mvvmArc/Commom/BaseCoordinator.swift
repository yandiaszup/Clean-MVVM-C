//
//  BaseCoordinator.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 10/05/21.
//

import Foundation

class BaseCoordinator<T> {
    func routeFrom(state: T) {
        fatalError("This method should be overridden")
    }
}
