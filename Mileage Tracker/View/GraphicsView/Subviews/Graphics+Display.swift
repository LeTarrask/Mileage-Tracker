//
//  Graphics+Display.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI
import Charts

extension GraphicsView {
    @ViewBuilder
    func graphicDisplay() -> some View {
        // MARK: - Graphic
        ZStack {
            settingsMG.theme.backgroundColor
                .cornerRadius(25)

            Chart(filterBy(timeframe), id: \.id) { refuel in
                switch graphType {
                case .spending:
                    BarMark(x: .value(dateLocalizedString, refuel.creationDate),
                            y: .value(refuelString, refuel.money)
                    )
                    .accessibilityValue(refuel.money.clean)
                    .foregroundStyle(settingsMG.theme.mainColor)
                case .dates:
                    PointMark(x: .value(dateLocalizedString, refuel.creationDate),
                              y: .value(priceString, refuel.pricePerLiter)
                    )
                    .foregroundStyle(settingsMG.theme.mainColor)
                case .km:
                    LineMark(x: .value(dateLocalizedString, refuel.creationDate),
                             y: .value(averageSpenValue, refuel.kmAdded/refuel.money)
                    )
                    .foregroundStyle(settingsMG.theme.mainColor)
                    .lineStyle(StrokeStyle(lineWidth: 2.0))
                    .interpolationMethod(.catmullRom)
                    .symbol(Circle().strokeBorder(lineWidth: 2.0))
                    .symbolSize(60)

                }
            }
            .padding([.horizontal, .top], 20)
        }.padding()
    }
}
