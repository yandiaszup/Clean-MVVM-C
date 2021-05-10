//
//  AuthenticationViewModel.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation
import Combine

enum ScreenEvent {
    case textChange(value: String)
    case didTouchButton
}

enum ScreenState {
    case idle
    case loading
    case error
    case success
}

class AuthenticationViewModel: BaseViewModel<ScreenState, ScreenEvent> {
    
    override func setState(state: ScreenState) {
        switch state {
        case .error:
            return
        case .idle:
            return
        case .loading:
            return
        case .success:
            return
        }
    }
    
    override func handleScreenEvent(_ event: ScreenEvent) {
        switch event {
        case .didTouchButton:
            didTouchButton()
        case .textChange(let value):
            textDidChange(value: value)
        }
    }
    
    // MARK: Dependencies
    
    var authenticateUseCase: AuthenticateUseCaseProtocol? = AuthenticateUseCase()
    
    // MARK: ScreenViewModelOutput
    
    private(set) var isButtonEnabledPublisher = PassthroughSubject<Bool, Never>()
    
    // MARK: Properties
    
    private var isButtonEnabled: Bool = false {
        didSet {
            isButtonEnabledPublisher.send(isButtonEnabled)
        }
    }
    
    private var state: ScreenState = .idle {
        didSet {
            viewModelStatePublisher.send(state)
        }
    }
    
    private var user: String = ""
    
    // MARK: Functions
    
    private func textDidChange(value: String) {
        isButtonEnabled = !value.isEmpty
        observable.value = value
        user = value
    }
    
    private func didTouchButton() {
        state = .loading
        authenticateUseCase?.execute(
            user: user,
            password: "",
            completion: { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.state = .success
                }
            }
        )
    }
}
