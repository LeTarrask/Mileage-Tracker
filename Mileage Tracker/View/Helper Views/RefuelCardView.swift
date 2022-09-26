//
//  CardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    var refuel: Refuel

    var average: Double

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    /// Localizable strings
    let sinceLast = NSLocalizedString("Since last", comment: "")
    let kmLabel = NSLocalizedString("km", comment: "")
    let literLabel = NSLocalizedString("L", comment: "")
    let fuelLabel = NSLocalizedString("Fuel", comment: "")
    let euroLabel = NSLocalizedString("€", comment: "")
    let paymentLabel = NSLocalizedString("Payment", comment: "")
    let thanAverageLabel = NSLocalizedString("than average:", comment: "")
    let perLiter = NSLocalizedString("per liter:", comment: "")
    let totalLabel = NSLocalizedString("Total", comment: "")
    let refuelAtLabel = NSLocalizedString("Refuel at: ", comment: "")

    var body: some View {
        ZStack {
            BackgroundCard()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Square(icon: "car",
                           number: refuel.kmAdded,
                           value: kmLabel,
                           label: sinceLast)
                    Spacer()
                    Square(icon: "drop.fill",
                           number: refuel.liters,
                           value: literLabel,
                           label: fuelLabel)
                    Spacer()
                    Square(icon: "eurosign.square",
                           number: refuel.money,
                           value: euroLabel,
                           label: paymentLabel)
                    Spacer()
                    Square(icon: "triangle.fill",
                           number: refuel.pricePerLiter-average,
                           value: euroLabel,
                           label: thanAverageLabel)
                }
                .padding(.bottom)
                HStack {
                    Square(icon: nil,
                           number: refuel.pricePerLiter,
                           value: euroLabel,
                           label: perLiter)
                    Spacer()
                    Square(icon: nil,
                           number: refuel.totalKM,
                           value: kmLabel,
                           label: totalLabel)
                }
                .padding(.bottom)
                HStack {
                    Text(refuelAtLabel)
                        .font(.caption)
                    Text(dateToString(date: refuel.creationDate))
                        .font(.caption)
                }
                .foregroundColor(themeMG.theme.backgroundColor)
            }.padding()
        }
    }
}



struct Previews_RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        return RefuelCardView(refuel: tracker.refuels[0],
                              average: tracker.averagePrice)
    }
}
