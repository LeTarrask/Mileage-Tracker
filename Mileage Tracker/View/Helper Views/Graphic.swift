//
//  Graphic.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView

struct Graphic: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker: MileageTracker
    @Binding var type: GraphType

    /// Localizable strings
    let refuelString = NSLocalizedString("Refuel cost", comment: "")
    let priceString = NSLocalizedString("Price/liter", comment: "")
    let kmRefuelString = NSLocalizedString("Km/refuel", comment: "")

    var body: some View {
        let chartStyle = ChartStyle(backgroundColor: themeMG.theme.backgroundColor,
                                    accentColor: themeMG.theme.mainColor,
                                    gradientColor: GradientColor(start:
                                                                    themeMG.theme.highlightColor,
                                                                 end: themeMG.theme.mainColor),
                                    textColor: themeMG.theme.mainColor,
                                    legendTextColor: themeMG.theme.secondaryColor,
                                    dropShadowColor: .gray)

        switch type {
        case .spending:
            LineView(data: tracker.refuels.map { $0.money },
                     title: refuelString, style: chartStyle)

        case .dates:
            LineView(data: tracker.refuels.map {
                        Double($0.pricePerLiter) },
                     title: priceString, style: chartStyle)
        case .km:
            LineView(data: tracker.refuels.map { $0.kmAdded },
                     title: kmRefuelString, style: chartStyle)
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
