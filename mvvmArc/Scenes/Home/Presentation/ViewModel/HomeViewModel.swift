//
//  HomeViewModel.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 13/05/21.
//

import Foundation
import Combine

protocol HomeViewModelInput {
    func setupEventListener(publisher: PassthroughSubject<HomeScreenEvent, Never>)
}

protocol HomeViewModelOutput {
    var viewModelStatePublisher: Observable<HomeState>? { get }
    var observable: Observable<String>? { get }
}

protocol HomeViewModelStateProtocol: class {
    func setState(_ state: HomeState)
}

protocol HomeViewModelViewProtocol: HomeViewModelOutput,
                                    HomeViewModelInput {}

protocol HomeViewModelProtocol: HomeViewModelStateProtocol,
                                HomeViewModelViewProtocol {}

class HomeViewModel: HomeViewModelProtocol {
    // Combine
    var viewModelStatePublisher: Observable<HomeState>?
    var observable: Observable<String>?
    private(set) var eventListener: AnyCancellable?
    // Arch
    var controller: HomeControllerProtocol?
    var coordinator: HomeCoordinatorProtocol?
    
    func setupEventListener(publisher: PassthroughSubject<HomeScreenEvent, Never>) {
        eventListener = publisher.sink(
            receiveValue: { self.handleScreenEvent($0) }
        )
    }
    
    func setState(_ state: HomeState) {
        showMood(state)
    }
    
    private func showMood(_ state: HomeState) {
        let mood: String
        switch state {
        case .happy:
            mood = ":)"
        case .sad:
            mood = ":("
        case .indifferent:
            mood = ":|"
        }
        coordinator?.showAlert(withTitle: "Mood", text: mood)
    }
    
    // Privates
    
    private func handleScreenEvent(_ event: HomeScreenEvent) {
        switch event {
        case .buttonTouched:
            controller?.handleButtonTouched()
        }
    }
}
