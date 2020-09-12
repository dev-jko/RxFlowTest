//
//  WatchedViewController.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/11.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

class WatchedViewController: UIViewController {
    
    private let viewModel: WatchedViewModel
    private let services: AppServices
    
    init(viewModel: WatchedViewModel, services: AppServices) {
        self.viewModel = viewModel
        self.services = services
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class WatchedViewModel: Stepper {
    let movies: [MovieViewModel]
    let steps: PublishRelay<Step> = PublishRelay()
    
    init(services: AppServices) {
        self.movies = services.watchedMovies()
            .map({ movie in
                return MovieViewModel(id: movie.id, title: movie.title)
            })
    }
    
    public func pick(movieId: Int) {
        self.steps.accept(DemoStep.movieIsPicked(withId: movieId))
    }
}

struct MovieViewModel {
    let id: Int
    let title: String
}
