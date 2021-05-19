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
    @State var text: String = "" {
        didSet {
            print(text)
        }
    }
    
    var eventPublisher = PassthroughSubject<ScreenEvent, Never>()
    
    init(viewModel: Model) {
        self.viewModel = viewModel
//        self.viewModel.setupEventListener(publisher: eventPublisher)
    }
    
    var body: some View {
        VStack {
//            Text(viewModel.test)
            Button("oi") {
                eventPublisher.send(.didTouchButton)
                test()
            }
            DSButton(title: "primary", kind: .primary)
                .frame(height: 60)
                .padding()
            DSButton(title: "secondary", kind: .secondary)
                .frame(height: 60)
                .padding()
            DSButton(title: "tertiary", kind: .tertiary)
                .frame(height: 60)
                .padding()
            DSTextField(hint: "hint", text: $text)
                .frame(height: 60)
            Text(text)
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
