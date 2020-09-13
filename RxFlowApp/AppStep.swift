//
//  AppStep.swift
//  RxFlowApp
//
//  Created by Jaedoo Ko on 2020/09/13.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

enum AppStep: Step {
    case loginIsRequired
    case alret(String)
    case indexIsPicked(Int)
    case onboardingIsRequired
    case dashboardIsRequired
}

class AppStepper: Stepper {
    var steps: PublishRelay<Step> = PublishRelay()
    
    var initialStep: Step {
        return AppStep.dashboardIsRequired
    }
}

class AppFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .onboardingIsRequired:
            return navigateToOnboarding()
        case .dashboardIsRequired:
            return navigateToDashboard()
        default:
            return .none
        }
    }
    
    private func navigateToOnboarding() -> FlowContributors {
        let flow = OnboardingFlow()
        
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: false)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: flow,
                                                 withNextStepper: OneStepper(withSingleStep: AppStep.dashboardIsRequired)))
    }
    
    private func navigateToDashboard() -> FlowContributors {
        let flow = DashboardFlow()
        
        Flows.use(flow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: false)
        }
        
        return .one(flowContributor: .contribute(withNextPresentable: flow,
                                                 withNextStepper: OneStepper(withSingleStep: AppStep.loginIsRequired)))
    }
}

class OnboardingFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
    
    
}

class DashboardFlow: Flow {
    var root: Presentable {
        return rootViewController
    }
    
    private let rootViewController = UITabBarController()
    
    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
    
    
}
