//
//  AuthenticationFactory.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 18/05/21.
//

import Foundation
import UIKit

class AuthenticationFactory: FactoryProtocol {
    static func make(with navigation: UINavigationController) -> UIViewController {
        let controller = AuthenticationController()
        let coordinator = AuthenticationCoordinator(navigationController: navigation)
        let viewModel = AuthenticationViewModel()
        let view = AuthenticationViewController()
        
        controller.viewModel = viewModel
        viewModel.controller = controller
        viewModel.coordinator = coordinator
        view.viewModel = viewModel
        
        return view
    }
}
