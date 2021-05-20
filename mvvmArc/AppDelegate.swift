//
//  AppDelegate.swift
//  mvvmArc
//
//  Created by Yan Dias on 04/05/21.
//

import UIKit
import Foundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigation = UINavigationController()
//        navigation.isNavigationBarHidden = true
        navigation.setViewControllers([AuthenticationFactory.make(with: navigation)], animated: false)
//        let authCoordinator = AuthenticationCoordinator(navigationController: UINavigationController())
        
//        authCoordinator.navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigation//authCoordinator.navigationController
        window?.makeKeyAndVisible()
        
//        authCoordinator.start()
        
        return true
    }

}
