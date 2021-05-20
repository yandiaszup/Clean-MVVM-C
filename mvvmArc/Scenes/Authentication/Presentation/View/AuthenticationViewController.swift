//
//  ViewController.swift
//  mvvmArc
//
//  Created by Yan Dias on 04/05/21.
//

import UIKit
import Combine

//MARK: - View

class AuthenticationViewController: UIViewController {
    
    // MARK: UI
    
    private let button = UIButton()
    private let textField = UITextField()
    private let state = UILabel()
    
    var text = "" {
        didSet {
            print(text)
        }
    }
    
    // MARK: Dependencies
    
    var viewModel: AuthenticationViewModelViewProtocol?
    
    // MARK: Publishers
    
    private let eventPublisher = PassthroughSubject<ScreenEvent, Never>()

    override func loadView() {
        super.loadView()
        
        buildView()
        setupBindings()
    }
    
    private func buildView() {
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(textField)
        view.addSubview(state)
        
        button.frame = CGRect(x: 20, y: 200, width: 200, height: 50)
        textField.frame = CGRect(x: 20, y: 120, width: 200, height: 50)
        state.frame = CGRect(x: 20, y: 300, width: 200, height: 50)
        
        textField.addTarget(self, action: #selector(textfieldChange), for: .editingChanged)
        button.addTarget(self, action: #selector(didTouchButton), for: .touchUpInside)
        
        button.backgroundColor = .gray
        textField.backgroundColor = .gray
        button.isEnabled = false
        
        button.setTitle("Button Enabled", for: .normal)
        button.setTitle("Button disabled", for: .disabled)
        
        state.text = "idle"
    }
    
    private func setupBindings() {
        viewModel?.setupEventListener(publisher: eventPublisher)
        
        //sink subscription
        viewModel?.isButtonEnabledPublisher.observe(on: self, observerBlock: { [weak self] value in
            guard let self = self else { return }
            self.button.backgroundColor = value ? .red : .gray
            self.button.isEnabled = value
        })
        
        viewModel?.viewModelStatePublisher.observe(on: self, observerBlock: { [weak self] state in
            guard let self = self else { return }
            
            self.handleScreenStateChange(state)
        })
        
        //Observable aproach (Not using Combine)
        viewModel?.observable.bind(to: \.text, on: self)
        viewModel?.observable.observe(on: self) { value in
            print(value)
        }
    }
    
    private func handleScreenStateChange(_ state: ScreenState) {
        switch state {
        case .idle:
            self.state.text = "idle"
        case .loading:
            self.state.text = "loading"
        case .success:
            self.state.text = "success"
        case .error:
            self.state.text = "error"
        }
    }
    
    // MARK: Screen Events
    
    @objc func textfieldChange() {
        eventPublisher.send(.textChange(value: textField.text ?? ""))
    }
    
    @objc func didTouchButton() {
        eventPublisher.send(.didTouchButton)
    }
}

