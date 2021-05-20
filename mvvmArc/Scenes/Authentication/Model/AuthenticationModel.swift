//
//  AuthenticationModel.swift
//  mvvmArc
//
//  Created by Victor Martins Rabelo on 12/05/21.
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
