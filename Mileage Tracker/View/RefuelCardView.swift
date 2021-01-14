//
//  RefuelCardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 13/01/2021.
//

import SwiftUI

struct RefuelCardView: View {
    var refuel: Refuel
    
    var body: some View {
        HStack {
            VStack {
                Text(refuel.kmString)
                Text("kilometers")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text(refuel.literString)
                Text("liters")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text(refuel.moneyString)
                Text("euros")
                    .font(.caption)
            }
        }
    }
}

