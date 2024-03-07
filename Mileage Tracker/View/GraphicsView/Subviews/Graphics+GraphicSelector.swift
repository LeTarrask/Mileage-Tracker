//
//  Graphics+Selector.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension GraphicsView {
    @ViewBuilder
    func graphicSelector() -> some View {
        // MARK: - Graphics Selector
        Picker(graphicString, selection: $graphType) {
            Text(refuelString).tag(GraphType.spending)
            Text(settingsMG.chosenCurrency+"/"+settingsMG.chosenVolume).tag(GraphType.dates)
            Text(settingsMG.chosenDistance+"/"+settingsMG.chosenCurrency).tag(GraphType.km)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 20)
    }
}
