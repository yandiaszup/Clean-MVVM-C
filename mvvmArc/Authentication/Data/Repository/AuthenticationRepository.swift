//
//  AuthenticationRepository.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation

protocol AuthenticationRepositoryProtocol {
    func authenticate(user: String, password: String, completion: (Bool) -> ())
}

struct AuthenticationRepository: AuthenticationRepositoryProtocol {
    
    func authenticate(user: String, password: String, completion: (Bool) -> ()) {
        completion(true)
    }
}
