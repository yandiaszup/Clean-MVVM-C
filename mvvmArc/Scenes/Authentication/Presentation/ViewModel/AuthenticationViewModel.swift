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

//protocol AuthenticationViewModelViewProtocol: AuthenticationViewModelInput, AuthenticationViewModelOutput {}

protocol AuthenticationViewModelViewProtocol: ViewModelProtocol {}

//protocol AuthenticationViewModelProtocol: AuthenticationViewModelViewProtocol, ViewModelProtocol {
//    func handle(screenEvent: ScreenEvent)
//    var isButtonEnabledObserver: Observable<Bool> { get }
//    var stateObserver: Observable<ScreenState> { get }
//}

protocol AuthenticationViewModelProtocol {
    func handle(screenEvent: ScreenEvent)
    var isButtonEnabledObserver: Observable<Bool> { get }
    var stateObserver: Observable<ScreenState> { get }
}

class AuthenticationViewModel: AuthenticationViewModelViewProtocol, AuthenticationViewModelProtocol, ObservableObject {
    
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
    
    func handle(screenEvent: ScreenEvent) {
        self.handleScreenEvent(screenEvent)
    }
}
