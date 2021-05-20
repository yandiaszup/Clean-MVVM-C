//
//  FactoryProtocol.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 17/05/21.
//

import UIKit

protocol FactoryProtocol {
    static func make(with navigation: UINavigationController) -> UIViewController
}
