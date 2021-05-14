//
//  AuthenticationView.swift
//  mvvmArc
//
//  Created by Yan Dias on 14/05/21.
//

import SwiftUI
import Combine

struct AuthenticationView<Model>: View where Model: AuthenticationViewModelProtocol & ObservableObject {
    
    @ObservedObject var viewModel: Model
    
    var ob = ObservableTestClass()
    
    var eventPublisher = PassthroughSubject<ScreenEvent, Never>()
    
    init(viewModel: Model) {
        self.viewModel = viewModel
        self.viewModel.setupEventListener(publisher: eventPublisher)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.test)
            Button("oi") {
                eventPublisher.send(.didTouchButton)
                test()
            }
        }
    }
    
    func test() {
        ob.test()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView<AuthenticationViewModel>(viewModel: AuthenticationViewModel())
    }
}
