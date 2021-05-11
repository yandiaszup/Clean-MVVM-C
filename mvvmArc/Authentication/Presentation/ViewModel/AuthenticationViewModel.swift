//
//  AuthenticationViewModel.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation
import Combine

typealias ScreenViewModelProtocol = ScreenViewModelOutput & BaseViewModel<ScreenState, ScreenEvent, ControllerEvent>

protocol ScreenViewModelOutput {
    var isButtonEnabledPublisher: PassthroughSubject<Bool, Never> { get }
    var observable: Observable<String> { get }
}

class AuthenticationViewModel: ScreenViewModelProtocol {
    
    // MARK: Dependencies
    
    var authenticateUseCase: AuthenticateUseCaseProtocol? = AuthenticateUseCase()
    
    // MARK: ScreenViewModelOutput
    
    private(set) var isButtonEnabledPublisher = PassthroughSubject<Bool, Never>()
    private(set) var observable: Observable<String> = .init("")
    
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
    
    // MARK: BaseViewModel
    
    override func setState(state: ScreenState) {
        switch state {
        case .error:
            return
        case .idle:
            return
        case .loading:
            return
        case .success:
            controller?.handle(action: .tryLogin)
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
