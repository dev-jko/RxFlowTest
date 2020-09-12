//
//  DashboardFlow.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/12.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class DashboardFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = UITabBarController()
    private let services: AppServices
    
    init(services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DemoStep else { return .none }
        
        switch step {
        case .dashboardIsRequired:
            return navigateToDashboard()
        default:
            return .none
        }
    }
    
    private func navigateToDashboard() -> FlowContributors {
        let watchedFlow = WatchedFlow(services: services)
        let watchedFlow2 = WatchedFlow(services: services)
        
        Flows.use(watchedFlow, watchedFlow2, when: .created) { [weak self] (root1, root2) in
            let tabBarItem1 = UITabBarItem(title: "Wishlist", image: #imageLiteral(resourceName: "wishlist"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Watched", image: #imageLiteral(resourceName: "watched"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1
            root1.title = "Wishlist"
            root2.tabBarItem = tabBarItem2
            root2.title = "Watched"
            
            self?.rootViewController.setViewControllers([root1, root2], animated: false)
        }
        
        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: watchedFlow,
                withNextStepper: OneStepper(withSingleStep: DemoStep.moviesAreRequired)
            ),
            .contribute(
                withNextPresentable: watchedFlow2,
                withNextStepper: OneStepper(withSingleStep: DemoStep.moviesAreRequired)
            )
        ])
    }
}
