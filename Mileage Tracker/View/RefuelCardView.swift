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
    let number: Double
    let value: String
    let label: String
    var flip: Bool {
        icon == "triangle.fill"
    }

    var body: some View {
        VStack(alignment: .center) {
            if icon != nil {
                Image(systemName: icon!)
                    .font(.largeTitle)
                    .rotationEffect(number < 0 ? .degrees(-180) : .zero)
                    .foregroundColor(number < 0 ? .green : flip ? .red : Color("Cream"))
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(String(number.rounded(toPlaces: 2)))
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
