//
//  AuthenticationViewModel.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation

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

protocol AuthenticationViewModelProtocol {
    func handle(screenEvent: ScreenEvent)
    var isButtonEnabledObserver: Observable<Bool> { get }
    var stateObserver: Observable<ScreenState> { get }
}

class AuthenticationViewModel: AuthenticationViewModelProtocol, ObservableObject {
    
    // MARK: Dependencies
    
    var authenticateUseCase: AuthenticateUseCaseProtocol? = AuthenticateUseCase()
    
    weak var coordinator: AuthenticationCoordinatorDelegate?
    
    // MARK: Observers
    
    var isButtonEnabledObserver: Observable<Bool> { $isButtonEnabled }
    var stateObserver: Observable<ScreenState> { $state }
    
    // MARK: Properties
    
    @ObservableValue private var isButtonEnabled: Bool = false
    @ObservableValue private var state: ScreenState = .idle
    
    private var user: String = ""
    
    // MARK: Functions
    
    private func handleScreenEvent(_ event: ScreenEvent) {
        switch event {
        case .didTouchButton:
            didTouchButton()
        case .textChange(let value):
            textDidChange(value: value)
        }
    }
    
    private func textDidChange(value: String) {
        isButtonEnabled = !value.isEmpty
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
    
    // MARK: ScreenViewModelInput
    
    func handle(screenEvent: ScreenEvent) {
        self.handleScreenEvent(screenEvent)
    }
}
