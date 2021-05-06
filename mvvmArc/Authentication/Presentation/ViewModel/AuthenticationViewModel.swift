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

protocol AuthenticationViewModelInput {
    func setupEventListener(publisher: PassthroughSubject<ScreenEvent, Never>)
}

protocol AuthenticationViewModelOutput {
    var viewModelStatePublisher: PassthroughSubject<ScreenState, Never> { get }
    var isButtonEnabledPublisher: PassthroughSubject<Bool, Never> { get }
    var observable: Observable<String> { get }
}

protocol AuthenticationViewModelProtocol: AuthenticationViewModelInput, AuthenticationViewModelOutput { }

class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    // MARK: Dependencies
    
    var authenticateUseCase: AuthenticateUseCaseProtocol? = AuthenticateUseCase()
    
    weak var coordinator: AuthenticationCoordinatorDelegate?
    
    // MARK: ScreenViewModelOutput
    
    var observable: Observable<String> = Observable("")
    private(set) var isButtonEnabledPublisher = PassthroughSubject<Bool, Never>()
    private(set) var viewModelStatePublisher = PassthroughSubject<ScreenState, Never>()
    
    // MARK: Properties
    
    private(set) var eventListener: AnyCancellable?
    
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
    
    // MARK: ScreenViewModelInput
    
    func setupEventListener(publisher: PassthroughSubject<ScreenEvent, Never>) {
        eventListener = publisher.sink(
            receiveValue: { self.handleScreenEvent($0) }
        )
    }
}
