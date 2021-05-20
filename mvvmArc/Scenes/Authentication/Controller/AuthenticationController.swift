//
//  AuthenticationController.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 12/05/21.
//

import Foundation

protocol AuthenticationControllerProtocol {
    func handleLogin(user: String, password: String)
}

class AuthenticationController: AuthenticationControllerProtocol {
    
    weak var viewModel: ViewModelProtocol?
    var loginUsecase: AuthenticateUseCaseProtocol?
    
    func handleLogin(user: String, password: String) {
        viewModel?.setState(state: .success)
//        loginUsecase?.execute(user: user, password: password, completion: { loged in
//            return
//        })
    }
}
