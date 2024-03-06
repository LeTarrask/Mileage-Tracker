//
//  MainAppTabs.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var settingsMG: SettingsManager

    @StateObject var tracker = MileageTracker.shared

    @StateObject var viewRouter = ViewRouter.shared

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Main Page Views Switcher
            mainSwitcher()
            // MARK: - Tab Bar
            tabBar()
        }
        .environmentObject(tracker)
        .environmentObject(viewRouter)
        .edgesIgnoringSafeArea([.bottom, .horizontal])
    }
    
    @ViewBuilder
    func mainSwitcher() -> some View {
        switch viewRouter.currentPage {
        case .mileage:
            MileageView()
        case .othercosts:
            OtherCostsView()
        case .addobject:
            AddObjectView()
        case .graphics:
            GraphicsView()
        case .settings:
            SettingsView()
        }
    }
    
    @ViewBuilder
    func tabBar() -> some View {
        ZStack {
            HStack(spacing: 25) {
                // MileageView
                TabBarIcon(assignedPage: .mileage,
                           systemIconName: "drop.fill",
                           tabName: refuelsString)
                
                // OtherCostsView
                TabBarIcon(assignedPage: .othercosts,
                           systemIconName: "wrench.and.screwdriver",
                           tabName: otherCostsString)
                
                // New Add Button
                TabBarIcon(assignedPage: .addobject,
                           systemIconName: "plus.circle.fill",
                           tabName: addCostString)
                
                // StatsView
                TabBarIcon(assignedPage: .graphics,
                           systemIconName: "list.star",
                           tabName: statsString)
                
                // SettingsView
                TabBarIcon(assignedPage: .settings,
                           systemIconName: "gearshape",
                           tabName: settingsString)
            }
            .frame(maxWidth: .infinity, maxHeight: 70)
            .background(settingsMG.theme.backgroundColor.shadow(radius: 2))
        }
    }
}

struct MainAppTabs_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
            .environment(\.locale, .init(identifier: "pt-BR"))
        
        MainAppView()
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
        
        MainAppView()
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
            .previewDisplayName("iPad (9th generation)")
    }
}
