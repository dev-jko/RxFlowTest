//
//  MovieDetailViewController.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/12.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxCocoa
import RxFlow

class MovieDetailViewModel: Stepper {
    let steps: PublishRelay<Step> = PublishRelay()
    
    let movieId: Int
    
    private(set) var title = ""
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func pick(castId: Int) {
        steps.accept(DemoStep.castIsPicked(withId: castId))
    }
}

class MovieDetailViewController: UIViewController {
    
    let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
