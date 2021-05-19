//
//  a.swift
//  mvvmArc
//
//  Created by Yan Dias on 17/05/21.
//

import SwiftUI
import UIKit
import Beaxel

struct DSButton: UIViewRepresentable {
    
    var title: String
    
    var kind: Beaxel.Button.Kind
    
    func makeUIView(context: Context) -> Beaxel.Button {
        Beaxel.Button(text: title, kind: kind)
    }
    
    func updateUIView(_ uiView: Beaxel.Button, context: Context) {
        
    }
}
