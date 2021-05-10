//
//  AuthenticationCoordinator.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func login()
}

class AuthenticationCoordinator: BaseCoordinator<ScreenState>, Coordinator, AuthenticationCoordinatorDelegate {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func routeFrom(state: ScreenState) {
        
    }
    
    func start() {
        let vc = AuthenticationViewController()
        let viewModel = AuthenticationViewModel()
        
        viewModel.coordinator = self
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    // MARK: AuthenticationCoordinatorProtocol
    
    func login() {
        
    }
}
