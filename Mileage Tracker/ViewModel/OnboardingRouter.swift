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
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }

    func dismissOnboard() {
        currentPage = "homeView"
    }

    @Published var currentPage: String
}
