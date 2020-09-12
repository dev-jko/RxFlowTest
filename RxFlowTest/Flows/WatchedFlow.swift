//
//  DemoFlow.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/11.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow

class WatchedFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let services: AppServices
    
    init(services: AppServices) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DemoStep else { return .none }
        
        switch step {
        case .moviesAreRequired:
            return navigateToMovieListScreen()
        case .movieIsPicked(let movieId):
            return navigateToMovieDetailScreen(movieId: movieId)
//        case .castIsPicked(let castId):
//            return navigateToCastDetailScreen(castId)
        default:
            return .none
        }
    }
    
    private func navigateToMovieListScreen() -> FlowContributors {
        let viewModel = WatchedViewModel(services: services)
        let viewController = WatchedViewController(
            viewModel: viewModel,
            services: self.services
        )
        
        viewController.title = "Watched"
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
    
    private func navigateToMovieDetailScreen(movieId: Int) -> FlowContributors {
        let viewModel = MovieDetailViewModel(movieId: movieId)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        viewController.title = viewModel.title
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
    }
}
