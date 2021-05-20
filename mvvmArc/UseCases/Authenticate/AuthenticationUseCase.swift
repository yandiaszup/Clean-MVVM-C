//
//  AuthenticationUseCase.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation

protocol AuthenticateUseCaseProtocol {
    func execute(user: String, password: String, completion: (Bool) -> ())
}

class AuthenticateUseCase: AuthenticateUseCaseProtocol {
    
    var repository: AuthenticationRepositoryProtocol? = AuthenticationRepository()
    
    func execute(
        user: String,
        password: String,
        completion: (Bool) -> ()
    ) {
        repository?.authenticate(user: user, password: password, completion: completion)
    }
}
