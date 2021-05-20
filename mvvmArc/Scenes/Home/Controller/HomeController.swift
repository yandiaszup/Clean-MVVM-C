//
//  HomeController.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 13/05/21.
//

import Foundation

protocol HomeControllerProtocol {
    func handleButtonTouched()
}


class HomeController: HomeControllerProtocol {
    
    weak var viewModel: HomeViewModelStateProtocol?
    
    func handleButtonTouched() {
        let mood = Int.random(in: 0...2)
        switch mood {
        case 0:
            viewModel?.setState(.happy)
        case 1:
            viewModel?.setState(.sad)
        default:
            viewModel?.setState(.indifferent)
        }
    }
}
