//
//  Mileage_TrackerApp.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct MileageTrackerApp: App {
    private var onboardRouter: OnboardingRouter = OnboardingRouter()

    var body: some Scene {
        WindowGroup {
            VStack {
                if onboardRouter.currentPage == "onboardingView" {
                    OnboardingView(pages: OnboardingPage.fullOnboarding)
                } else if onboardRouter.currentPage == "homeView" {
                    MainAppView()
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
