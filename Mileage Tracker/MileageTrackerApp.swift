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
                    TabView {
                        MileageView(tracker: tracker) {
                            tracker.save()
                        }.tabItem {
                            Image(systemName: "drop.fill")
                            Text(refuelsString)
                        }.foregroundColor(themeMG.theme.mainColor)
                        OtherCostsView(tracker: tracker) {
                            tracker.save()
                        }.tabItem {
                            Image(systemName: "wrench.and.screwdriver")
                            Text(otherCostsString)
                        }.foregroundColor(themeMG.theme.mainColor)
                        GraphicsView(tracker: tracker)
                            .tabItem {
                                Image(systemName: "list.star")
                                Text(statsString)
                            }.foregroundColor(themeMG.theme.mainColor)
                        SettingsView(tracker: tracker)
                            .tabItem {
                                Image(systemName: "gearshape")
                                Text(settingsString)
                            }.foregroundColor(themeMG.theme.mainColor)
                    }
    
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

class ViewRouter: ObservableObject {
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "homeView"
        }
    }

    @Published var currentPage: String
}
