//
//  AppDelegate.swift
//  mvvmArc
//
//  Created by Yan Dias on 04/05/21.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let authCoordinator = AuthenticationCoordinator(navigationController: UINavigationController())
        
        authCoordinator.navigationController.isNavigationBarHidden = true
        window?.rootViewController = authCoordinator.navigationController
        window?.makeKeyAndVisible()
        
        authCoordinator.start()
        
        return true
    }

}

