//
//  MainAppTabs.swift
// Fuel Logue
//
//  Created by Alex Luna on 26/03/2021.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var settingsMG: SettingsManager

    @StateObject var mileageVM = MileageViewModel.shared

    @StateObject var viewRouter = ViewRouter()

    var body: some View {
        VStack(spacing: 0) {
            mainSwitcher()

            tabBar()
        }
        .environmentObject(mileageVM)
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
