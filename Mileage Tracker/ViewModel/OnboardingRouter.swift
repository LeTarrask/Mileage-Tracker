//
//  ViewRouter.swift
// Fuel Logue
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

/**
     Initializes a new instance of `OnboardingRouter`.

     The initialization checks if the app has been launched before by looking at the value stored in `UserDefaults`.
     If it's the first launch, the onboarding page is displayed. Otherwise, the home page is displayed.
*/
class OnboardingRouter: ObservableObject {
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = .onboarding
        } else {
            currentPage = .home
        }
    }

    /**
         Dismisses the onboarding and sets the current page to the home page.
    */
    func dismissOnboard() {
        currentPage = .home
    }

    @Published var currentPage: LoadingState
}

/**
 Possible loading states of the app.
*/
enum LoadingState {
    case onboarding
    case home
}
