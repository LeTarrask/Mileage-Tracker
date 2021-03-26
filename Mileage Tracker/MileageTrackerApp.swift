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

    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    private var viewRouter: ViewRouter = ViewRouter()

    /// VIEW STRINGS & URLs
    let refuelsString = NSLocalizedString("Refuels", comment: "")
    let otherCostsString = NSLocalizedString("Other costs", comment: "")
    let statsString = NSLocalizedString("Stats", comment: "")
    let settingsString = NSLocalizedString("Settings", comment: "")

    var body: some Scene {
        WindowGroup {
            VStack {
                if viewRouter.currentPage == "onboardingView" {
                    OnboardingView(pages: OnboardingPage.fullOnboarding)
                } else if viewRouter.currentPage == "homeView" {
                    MainAppTabs()
                }
            }
            .accentColor(themeMG.theme.mainColor)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                tracker.load()
            }
        }
    }
}
