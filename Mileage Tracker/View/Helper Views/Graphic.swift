//
//  Graphic.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView

struct Graphic: View {
    var theme: Theme = ThemeManager.currentTheme()

    @ObservedObject var tracker: MileageTracker
    @Binding var type: GraphType

    var body: some View {
        let chartStyle = ChartStyle(backgroundColor: theme.backgroundColor,
                                    accentColor: theme.mainColor,
                                    gradientColor: GradientColor(start:
                                                                    theme.highlightColor,
                                                                 end: theme.mainColor),
                                    textColor: theme.mainColor,
                                    legendTextColor: theme.secondaryColor,
                                    dropShadowColor: .gray)

        switch type {
        case .spending:
            LineView(data: tracker.refuels.map { $0.money },
                     title: "Refuel cost", style: chartStyle)

        case .dates:
            LineView(data: tracker.refuels.map {
                        Double($0.pricePerLiter) },
                     title: "Price per liter", style: chartStyle)
        case .km:
            LineView(data: tracker.refuels.map { $0.kmAdded }, title: "KM per Refuel", style: chartStyle)
        }
    }
}

struct Graphic_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.loadTestData()
        return Graphic(tracker: tracker, type: .constant(.spending))
    }
}
