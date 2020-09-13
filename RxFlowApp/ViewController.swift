//
//  ViewController.swift
//  RxFlowApp
//
//  Created by Jaedoo Ko on 2020/09/13.
//  Copyright © 2020 jko. All rights reserved.
//

import UIKit
import SnapKit
import RxFlow

class ViewController: UIViewController {

    private let label = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        view.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
    }
}

