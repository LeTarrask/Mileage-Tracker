//
//  RefuelCardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 13/01/2021.
//

import SwiftUI

struct RefuelCardView: View {
    var refuel: Refuel

    var average: Double

    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(NSLocalizedString("Refuel at: ", comment: ""))
                    .font(.headline)
                Text(formatter.string(from: refuel.creationDate))
                    .font(.caption)
            }.padding(.bottom)
            HStack(alignment: .center) {
                VStack {
                    Text(NSLocalizedString("Total", comment: ""))
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(String(refuel.totalKM))
                        Text(NSLocalizedString("km", comment: ""))
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text(NSLocalizedString("Since last", comment: ""))
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(String(refuel.kmAdded.clean))
                        Text(NSLocalizedString("km", comment: ""))
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text(NSLocalizedString("Fuel", comment: ""))
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(String(refuel.liters))
                        Text(NSLocalizedString("L", comment: ""))
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text(NSLocalizedString("Payment", comment: ""))
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(String(refuel.money))
                        Text(NSLocalizedString("€", comment: ""))
                    }.font(.subheadline)
                }
            }.padding(.bottom)
            HStack {
                Text(NSLocalizedString("Price per liter:", comment: ""))
                    .font(.headline)
                HStack {
                    Text(String(refuel.pricePerLiter))
                    Text(NSLocalizedString("€", comment: ""))
                }
            }
            HStack {
                Text(NSLocalizedString("Difference from average:", comment: ""))
                    .font(.headline)
                HStack {
                    Text(String((refuel.pricePerLiter-average).rounded(toPlaces: 2)))
                    Text(NSLocalizedString("€", comment: ""))
                }
            }
        }.padding(.bottom)
    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let refuel = Refuel(totalKM: 2329, liters: 23.99, money: 23.09, kmAdded: 123)
        return RefuelCardView(refuel: refuel, average: 1.45)
    }
}
