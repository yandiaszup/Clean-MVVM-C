//
//  HomeFactory.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 17/05/21.
//

import Foundation
import UIKit
 
class HomeFactory: FactoryProtocol {
    static func make(with navigation: UINavigationController) -> UIViewController {
        let controller = HomeController()
        let coordinator = HomeCoordinator()
        let viewModel = HomeViewModel()
        let view = HomeView()
        
        controller.viewModel = viewModel
        viewModel.controller = controller
        viewModel.coordinator = coordinator
        view.viewModel = viewModel
        coordinator.navigation = navigation
        
        return view
    }
}
