//
//  OnboardingFlow.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/12.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class OnboardingFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "Onboarding"
        return viewController
    }()
    
    private let services: AppServices
    
    init(services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DemoStep else { return .none }
        
        switch step {
        case .loginIsRequired:
            return navigateToLoginScreen()
        case .userIsLoggedIn:
            return navigateToApiScreen()
        default:
            return .none
        }
    }
    
    private func navigateToLoginScreen() -> FlowContributors {
        let settingsLoginViewController = SettingsLoginViewController()
        settingsLoginViewController.title = "Login"
        rootViewController.pushViewController(settingsLoginViewController, animated: false)
        return .one(flowContributor: .contribute(withNext: settingsLoginViewController))
    }
    
    private func navigateToApiScreen() -> FlowContributors {
        let settingsLoginViewController = SettingsLoginViewController()
        settingsLoginViewController.title = "Api"
        rootViewController.pushViewController(settingsLoginViewController, animated: true)
        return .one(flowContributor: .contribute(withNext: settingsLoginViewController))
    }
}
