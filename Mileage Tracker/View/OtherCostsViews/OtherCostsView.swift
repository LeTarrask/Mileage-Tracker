//
//  OtherCostsView.swift
//  Fuel Logue
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @EnvironmentObject var mileageVM: MileageViewModel
    @EnvironmentObject var settingsMG: SettingsManager

    @State private var newCostData = OtherCost.Data()

    var body: some View {
        VStack {
            if mileageVM.otherCosts.isEmpty {
                // MARK: Shows if there's no data
                LoadingView(headline: loadCostsHeadline,
                            paragraph: loadCostsParagraph,
                            image: "bicycle")
            } else {
                otherCostDisplay()
                    .background(settingsMG.theme.secondColor)
            }
        }
    }
}

struct OtherCostsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherCostsView()
            .environmentObject(MileageViewModel.shared)
            .environmentObject(SettingsManager.shared)
    }
}
