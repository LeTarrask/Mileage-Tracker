//
//  MainApp+TabBar.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension MainAppView {
    @ViewBuilder
    func tabBar() -> some View {
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
        .background(settingsMG.theme.backgroundColor.shadow(radius: 4))
    }
}
