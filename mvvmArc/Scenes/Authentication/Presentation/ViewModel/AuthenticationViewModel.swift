//
//  AuthenticationViewModel.swift
//  mvvmArc
//
//  Created by Yan Dias on 06/05/21.
//

import Foundation
import Combine

protocol AuthenticationViewModelInput {
    func setupEventListener(publisher: PassthroughSubject<ScreenEvent, Never>)
}

protocol AuthenticationViewModelOutput {
    var viewModelStatePublisher: Observable<ScreenState> { get }
    var isButtonEnabledPublisher: Observable<Bool> { get }
    var observable: Observable<String> { get }
}

protocol ViewModelProtocol: class {
    func setState(state: ScreenState)
}

protocol AuthenticationViewModelViewProtocol: AuthenticationViewModelInput, AuthenticationViewModelOutput {}

protocol AuthenticationViewModelProtocol: AuthenticationViewModelViewProtocol, ViewModelProtocol { }

class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    func setState(state: ScreenState) {
        switch state {
        case .success:
            coordinator?.login()
        default:
            return
        }
    }
    
    // MARK: Dependencies
    
    var coordinator: AuthenticationCoordinatorDelegate?
    var controller: AuthenticationControllerProtocol?
    
    // MARK: ScreenViewModelOutput
    
    var observable: Observable<String> = Observable("")
    private(set) var isButtonEnabledPublisher = Observable<Bool>(false)
    private(set) var viewModelStatePublisher = Observable<ScreenState>(.idle)
    
    // MARK: Properties
    
    private(set) var eventListener: AnyCancellable?
    
    private var isButtonEnabled: Bool = false {
        didSet {
            isButtonEnabledPublisher.value = isButtonEnabled
        }
    }
    
    private var state: ScreenState = .idle {
        didSet {
            viewModelStatePublisher.value = state
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
//        state = .loading
        controller?.handleLogin(user: "", password: "")
//        authenticateUseCase?.execute(
//            user: user,
//            password: "",
//            completion: { value in
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.state = .success
//                }
//            }
//        )
    }
    
    // MARK: ScreenViewModelInput
    
    func setupEventListener(publisher: PassthroughSubject<ScreenEvent, Never>) {
        eventListener = publisher.sink(
            receiveValue: { self.handleScreenEvent($0) }
        )
    }
}
