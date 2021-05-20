//
//  TextFieldView.swift
//  mvvmArc
//
//  Created by Yan Dias on 18/05/21.
//

import SwiftUI
import Beaxel

struct DSTextField: UIViewRepresentable {
    
    var hint: String
    var onChange: ((String?) -> Void)? = nil
    @Binding var text: String
    
    func makeUIView(context: Context) -> Beaxel.TextField {
        let view = Beaxel.TextField(inputType: .default, hint: hint)
        view.onChange = { text in
            self.text = text ?? ""
        }
        return view
    }
    
    func updateUIView(_ uiView: Beaxel.TextField, context: Context) {
        uiView.onChange = { text in
            self.text = text ?? ""
        }
    }
}
