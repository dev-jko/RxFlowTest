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
import SnapKit

class WatchedViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let viewModel: WatchedViewModel
    private let services: AppServices
    
    init(viewModel: WatchedViewModel, services: AppServices) {
        self.viewModel = viewModel
        self.services = services
        
        super.init(nibName: nil, bundle: nil)
        
        setupLayout()
        configureCollectionView()
        
        collectionView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension WatchedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let cell = collectionViewCell as? MovieCollectionViewCell else {
            return collectionViewCell
        }
        cell.title.text = viewModel.movies[indexPath.item].title
        return cell
    }
}

extension WatchedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.pick(movieId: viewModel.movies[indexPath.item].id)
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

class MovieCollectionViewCell: UICollectionViewCell {
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(title)
        title.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        title.textColor = .black
        title.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
