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
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(LinearGradient(gradient: Gradient(colors: [Color("Redder"), Color("Wine")]),
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Square(icon: "car", number: String(refuel.kmAdded.clean),
                           value: "km",
                           label: NSLocalizedString("Since last", comment: ""))
                    Spacer()
                    Square(icon: "drop.fill",
                           number: String(refuel.liters),
                           value: NSLocalizedString("L", comment: ""),
                           label: NSLocalizedString("Fuel", comment: ""))
                    Spacer()
                    Square(icon: "eurosign.square",
                           number: String(refuel.money),
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("Payment", comment: ""))
                    Spacer()
                    // TO DO: this math here is very strange
                    Square(icon: "drop",
                           number: String((refuel.pricePerLiter-average).rounded(toPlaces: 2)),
                           value: NSLocalizedString("€", comment: ""),
                           label: NSLocalizedString("than average:", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Spacer()
                    Square(icon: nil,
                           number: String(refuel.pricePerLiter),
                           value: "€",
                           label: NSLocalizedString("per liter:", comment: ""))
                    Square(icon: nil,
                           number: String(refuel.totalKM),
                           value: NSLocalizedString("km", comment: ""),
                           label: NSLocalizedString("Total", comment: ""))
                }
                .padding(.bottom)
                HStack {
                    Text(NSLocalizedString("Refuel at: ", comment: ""))
                        .font(.caption)
                    Text(formatter.string(from: refuel.creationDate))
                        .font(.caption)
                }
                .foregroundColor(Color("Cream"))
            }.padding()
        }
    }
}

struct Square: View {
    let icon: String?
    let number: String
    let value: String
    let label: String

    var body: some View {
        VStack(alignment: .center) {
            if icon != nil {
                Image(systemName: icon!)
                    .font(.largeTitle)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(number)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text(value)
                }
                Text(label)
                    .font(.caption)
            }
        }
        .foregroundColor(Color("Cream"))
    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let refuel = Refuel(totalKM: 2329, liters: 23.99, money: 23.09, kmAdded: 123)
        return RefuelCardView(refuel: refuel, average: 1.45)
            .previewLayout(.sizeThatFits)
    }
}
