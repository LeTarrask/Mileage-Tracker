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
        VStack(alignment: .center) {

            Text("Refuel at: " + dateToString(date: refuel.creationDate))
                .foregroundColor(themeMG.theme.mainColor)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(String(refuel.kmAdded) + " km")
                        .fontWeight(.bold)
                    Text("since last")
                        .fontWeight(.thin)
                }.foregroundColor(themeMG.theme.mainColor)

                VStack(alignment: .leading) {
                    Text(String(refuel.liters) + " liters")
                        .fontWeight(.bold)
                }.foregroundColor(themeMG.theme.mainColor)
            }.padding()

            HStack(alignment: .top) {
                Spacer()

                VStack(alignment: .leading) {
                    Text(String(refuel.pricePerLiter) + " €/liter")
                        .fontWeight(.bold)
                }.foregroundColor(themeMG.theme.mainColor)
            }.padding()

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(String(refuel.totalKM) + " km")
                        .fontWeight(.bold)
                    Text("total")
                        .fontWeight(.thin)
                }.foregroundColor(themeMG.theme.mainColor)

                VStack(alignment: .leading) {
                    Text(String(refuel.money) + "€ payment")
                        .fontWeight(.bold)
                }.foregroundColor(themeMG.theme.mainColor)
            }
            .padding()
        }
        .background(themeMG.theme.backgroundColor.cornerRadius(30))
        .padding()

    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        return RefuelCardView(refuel: tracker.refuels[0],
                              average: tracker.averagePrice)
    }
}
