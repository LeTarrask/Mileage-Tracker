//
//  MainAppTabs.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct MainAppView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    @ObservedObject var tracker = MileageTracker.shared
    
    @ObservedObject var viewRouter = ViewRouter.shared
    
    @State var showPopUp = false
    
    var body: some View {
        VStack {
            // MARK: - Main Page Views Switcher
            mainSwitcher()
            // MARK: - Tab Bar
            tabBar()
        }
        .background(Color.blue)
        .edgesIgnoringSafeArea([.bottom, .horizontal])
    }
    
    @ViewBuilder
    func mainSwitcher() -> some View {
        Group {
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
                           // TODO: create translatable string for Add Cost
                           tabName: "Add Cost")
                
                // StatsView
                TabBarIcon(assignedPage: .graphics,
                           systemIconName: "list.star",
                           tabName: statsString)
                
                // SettingsView
                TabBarIcon(assignedPage: .settings,
                           systemIconName: "gearshape",
                           tabName: settingsString)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 70)
            .background(themeMG.theme.backgroundColor.shadow(radius: 2))
        }
    }
}

struct MainAppTabs_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        MainAppView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
