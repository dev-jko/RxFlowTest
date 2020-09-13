//
//  AppDelegate.swift
//  RxFlowApp
//
//  Created by Jaedoo Ko on 2020/09/13.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let coordinator = FlowCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        guard let window = window else { return false }
        
        let flow = AppFlow()
        coordinator.coordinate(flow: flow)
        
        Flows.use(flow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
