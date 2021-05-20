//
//  HomeCoordinator.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 13/05/21.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func showAlert(withTitle title: String, text: String)
}

class HomeCoordinator: HomeCoordinatorProtocol {
    var navigation: UINavigationController?
    
    func showAlert(withTitle title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        navigation?.present(alert, animated: true, completion: nil)
    }
}
