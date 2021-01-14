//
//  RefuelDetail.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 13/01/2021.
//

import SwiftUI

struct RefuelDetail: View {
    var refuel: Refuel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Refuelled at:")
                Text(getDate(date: refuel.creationDate))
            }
            RefuelCardView(refuel: refuel)
            VStack(alignment: .leading) {
                Text("Price per liter:")
                HStack {
                    Text(refuel.pricePerLiter)
                    Text("€")
                }
            }
        }
    }
    
    func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter.string(from: date)
    }
}

struct RefuelDetail_Previews: PreviewProvider {
    static var previews: some View {
        RefuelDetail(refuel: Refuel.data[0])
    }
}
