//
//  Graphics+TimeframeSelector.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension GraphicsView {
    // MARK: - Averages display
    @ViewBuilder
    func timeframeSelector() -> some View {
        // MARK: - Timeframe selector
        Picker(timeframeString, selection: $timeframe) {
            Text(lastMonthString).tag(FilterType.month)
            Text(lastYearString).tag(FilterType.year)
            Text(allTimeString).tag(FilterType.none)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 20)
    }
}
