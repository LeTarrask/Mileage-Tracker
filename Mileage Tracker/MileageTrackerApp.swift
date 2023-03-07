//
//  Mileage_TrackerApp.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct MileageTrackerApp: App {
    @ObservedObject var onboardRouter: OnboardingRouter = OnboardingRouter()

    @State var onboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            VStack {
                MainAppView()
                    .onAppear {
                        if onboardRouter.currentPage == .onboarding {
                            onboarding.toggle()
                        }
                    }
            }
            .sheet(isPresented: $onboarding, content: {
                OnboardingView(pages: OnboardingPage.fullOnboarding)
            })
        }
    }
}
