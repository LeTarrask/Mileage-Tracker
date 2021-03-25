//
//  CardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    var theme: Theme = ThemeManager.currentTheme()

    var refuel: Refuel

    var average: Double

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        ZStack {
            BackgroundCard()
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Square(icon: "car",
                           number: refuel.kmAdded,
                           value: "km",
                           label: NSLocalizedString("Since last", comment: ""))
                    Spacer()
                    Square(icon: "drop.fill",
                           number: refuel.liters,
                           value: NSLocalizedString("L", comment: ""),
                           label: NSLocalizedString("Fuel", comment: ""))
                    Spacer()
                    Square(icon: "eurosign.square",
                           number: refuel.money,
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("Payment", comment: ""))
                    Spacer()
                    Square(icon: "triangle.fill",
                           number: refuel.pricePerLiter-average,
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("than average:", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Square(icon: nil,
                           number: refuel.pricePerLiter,
                           value: "€",
                           label: NSLocalizedString("per liter:", comment: ""))
                    Spacer()
                    Square(icon: nil,
                           number: refuel.totalKM,
                           value: NSLocalizedString("km", comment: ""),
                           label: NSLocalizedString("Total", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Text(NSLocalizedString("Refuel at: ", comment: ""))
                        .font(.caption)
                    Text(dateToString(date: refuel.creationDate))
                        .font(.caption)
                }
                .foregroundColor(theme.backgroundColor)
            }.padding()
        }
    }
}
