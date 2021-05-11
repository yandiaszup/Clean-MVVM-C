//
//  AuthenticationViewModelTests.swift
//  mvvmArcTests
//
//  Created by Yan Dias on 07/05/21.
//

import XCTest
import Combine
@testable import mvvmArc

class AuthenticationViewModelTests: XCTestCase {
    
    let sut = AuthenticationViewModel()
    
    let eventPublisher = PassthroughSubject<ScreenEvent, Never>()

    func testExample() {
        sut.setupEventListener(publisher: eventPublisher)
        
        eventPublisher.send(.didTouchButton)
    }
}

class AuthenticateUseCaseSpy: AuthenticateUseCaseProtocol {
    func execute(user: String, password: String, completion: (Bool) -> ()) {
        
    }
}
