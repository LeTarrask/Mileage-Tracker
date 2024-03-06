//
//  FuelLogueApp.swift
//  Fuel Logue
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

@main
struct FuelLogueApp: App {
    @StateObject var settingsMG: SettingsManager = SettingsManager.shared

    @StateObject var onboardRouter: OnboardingRouter = OnboardingRouter()

    @State var onboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            VStack {
                MainAppView()
                    .environmentObject(settingsMG)
                    .onAppear {
                        if onboardRouter.currentPage == .onboarding {
                            onboarding.toggle()
                        }
                    }
            }
            .sheet(isPresented: $onboarding, content: {
                OnboardingView(pages: OnboardingPage.fullOnboarding)
                    .environmentObject(settingsMG)
            })
        }
    }
}
