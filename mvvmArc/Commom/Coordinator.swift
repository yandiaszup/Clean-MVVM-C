//
//  Coordinator.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
