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
        VStack(alignment: .leading) {
            RefuelCardView(refuel: refuel)
                .padding(.vertical, 20)
            HStack {
                Text("Price per liter:")
                    .font(.headline)
                HStack {
                    Text(refuel.pricePerLiter)
                    Text("€")
                }
            }
        }
    }
}

struct RefuelDetail_Previews: PreviewProvider {
    static var previews: some View {
        RefuelDetail(refuel: Refuel.data[0])
    }
}
