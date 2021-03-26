//
//  Mileage_TrackerApp.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct MileageTrackerApp: App {
    @ObservedObject private var tracker = MileageTracker()

    private var onboardRouter: OnboardingRouter = OnboardingRouter()

    /// VIEW STRINGS & URLs
    let refuelsString = NSLocalizedString("Refuels", comment: "")
    let otherCostsString = NSLocalizedString("Other costs", comment: "")
    let statsString = NSLocalizedString("Stats", comment: "")
    let settingsString = NSLocalizedString("Settings", comment: "")

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
            .onAppear {
                tracker.load()
            }
        }
    }
}
