//
//  Graphic.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI
import SwiftUICharts // https://github.com/AppPear/ChartView

struct Graphic: View {
    @ObservedObject var tracker: MileageTracker
    @Binding var type: GraphType

    var body: some View {
        let chartStyle = ChartStyle(backgroundColor: Color("Cream"),
                                    accentColor: Color("Wine"),
                                    gradientColor: GradientColor(start:
                                                                    Color("Yellowish"),
                                                                 end: Color("Wine")),
                                    textColor: Color("Wine"),
                                    legendTextColor: Color("Redder"),
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

struct BackgroundCard: View {
    var body: some View {
        LinearGradient(gradient:
                        Gradient(colors: [Color("Redder"), Color("Wine")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .cornerRadius(15)
            .shadow(color: .black, radius: 3, x: 2, y: 1)
    }
}

struct Graphic_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.loadTestData()
        return Graphic(tracker: tracker, type: .constant(.spending))
    }
}
