//
//  ViewRouter.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

class OnboardingRouter: ObservableObject {
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = .onboarding
        } else {
            currentPage = .home
        }
    }

    func dismissOnboard() {
        currentPage = .home
    }

    @Published var currentPage: LoadingState
}

enum LoadingState {
    case onboarding
    case home
}
