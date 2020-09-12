//
//  AppFlow.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/11.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let services: AppServices
    
    init(services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DemoStep else { return .none }
        
        switch step {
        case .dashboardIsRequired:
            return navigateToDashboardScreen()
        case .onboardingIsRequired:
            return navigateToOnboardingScreen()
        case .onboardingIsComplete:
            return dismissOnboarding()
        default:
            return .none
        }
    }
    
    private func navigateToDashboardScreen() -> FlowContributors {
        let dashboardFlow = DashboardFlow(services: services)
        
        Flows.use(dashboardFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: false)
        }
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: dashboardFlow,
                withNextStepper: OneStepper(withSingleStep: DemoStep.dashboardIsRequired)
            )
        )
    }
    
    private func navigateToOnboardingScreen() -> FlowContributors {
        let onboardingFlow = OnboardingFlow(services: services)
        
        Flows.use(onboardingFlow, when: .created) { [weak self] root in
            self?.rootViewController.present(root, animated: true)
        }
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: onboardingFlow,
                withNextStepper: OneStepper(withSingleStep: DemoStep.loginIsRequired)
            )
        )
    }
    
    private func dismissOnboarding() -> FlowContributors {
        if let onboardingViewController = self.rootViewController.presentedViewController {
            onboardingViewController.dismiss(animated: true)
        }
        return .none
    }
}

class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    private let appServices: AppServices
    private let disposeBag = DisposeBag()
    
    init(services: AppServices) {
        self.appServices = services
    }
    
    var initialStep: Step {
        return DemoStep.dashboardIsRequired
    }
    
    func readyToEmitSteps() {
        self.appServices
            .returnBool(returnValue: false)
            .map { $0 ? DemoStep.onboardingIsComplete : DemoStep.onboardingIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}
