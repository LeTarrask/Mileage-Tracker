//
//  ContentView.swift
// Fuel Logue
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @EnvironmentObject var mileageVM: MileageViewModel
    @EnvironmentObject var settingsMG: SettingsManager

    var body: some View {
        if mileageVM.refuels.isEmpty {
            // MARK: - Loading screen when VM is empty
            LoadingView(headline: loadRefuelsHeadline, paragraph: loadRefuelParagraph, image: "fuelpump")
        } else {
            refuelsList()
        }
    }
}

struct MileageView_Previews: PreviewProvider {
    static var previews: some View {
        MileageView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)

        MileageView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
