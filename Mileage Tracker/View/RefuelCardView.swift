//
//  RefuelCardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 13/01/2021.
//

import SwiftUI

struct RefuelCardView: View {
    var refuel: Refuel
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Refuel at: ")
                    .font(.headline)
                Text(formatter.string(from: refuel.creationDate))
                    .font(.caption)
            }.padding(.bottom)
            HStack(alignment: .center) {
                VStack {
                    Text("Total")
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(refuel.kmString)
                        Text("km")
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text("Since last")
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(String(refuel.kmAdded.clean))
                        Text("km")
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text("Fuel")
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(refuel.literString)
                        Text("L")
                    }.font(.subheadline)
                }
                Spacer()
                VStack {
                    Text("Payment")
                        .font(.caption)
                        .fontWeight(.bold)
                    HStack {
                        Text(refuel.moneyString)
                        Text("€")
                    }.font(.subheadline)
                }
            }.padding(.bottom)
            HStack {
                Text("Price per liter:")
                    .font(.headline)
                HStack {
                    Text(refuel.pricePerLiter)
                    Text("€")
                }
            }
        }.padding(.bottom)
    }
}

struct RefuelCardView_Previews: PreviewProvider {    
    static var previews: some View {
        let refuel = Refuel(totalKM: 2329, liters: 23.99, money: 23.09, kmAdded: 123)
        return RefuelCardView(refuel: refuel)
    }
}
