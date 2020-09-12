//
//  DemoStep.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/11.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxFlow

enum DemoStep: Step {
    case loginIsRequired
    case userIsLoggedIn
    
    case onboardingIsRequired
    case onboardingIsComplete
    
    case dashboardIsRequired
    
    case moviesAreRequired
    case movieIsPicked(withId: Int)
    case castIsPicked(withId: Int)
    
    case settingsAreRequired
    case settingsAreComplete
}
