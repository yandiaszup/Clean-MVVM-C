//
//  HomeView.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 13/05/21.
//

import UIKit
import Combine

class HomeView: UIViewController {
    
    var viewModel: HomeViewModelViewProtocol?
    private let eventPublisher = PassthroughSubject<HomeScreenEvent, Never>()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Whats my mood?", for: .normal)
        
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        return button
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel?.setupEventListener(publisher: eventPublisher)
        
        //sink subscription
        viewModel?.viewModelStatePublisher?.observe(on: self, observerBlock: { [weak self] state in
            guard let self = self else { return }
        })
        
        //Observable aproach (Not using Combine)
//        viewModel?.observable.bind(to: \.text, on: self)
//        viewModel?.observable.observe(on: self) { value in
//            print(value)
//        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)
        
        label.frame = CGRect(x: 20, y: 200, width: 200, height: 50)
        button.frame = CGRect(x: 20, y: 300, width: 200, height: 50)
    }
    
    @objc private func buttonTouched() {
        eventPublisher.send(.buttonTouched)
    }
}
