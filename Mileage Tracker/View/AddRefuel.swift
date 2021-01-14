//
//  AddRefuel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI
import Combine

struct AddRefuel: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var refuelData: Refuel.Data
      
    var body: some View {
        Form {
            Section(header: Text("Add refuel info")) {
                // MARK: - KM
                HStack {
                    Text("Kilometers")
                    Spacer()
                    TextField("", text: $refuelData.kmString)
                        .keyboardType(.decimalPad)
                }
                // MARK: - Liters
                HStack {
                    Text("Liters")
                    Spacer()
                    TextField("", text: $refuelData.litersString)
                        .keyboardType(.decimalPad)
                }
                // MARK: - Cost
                HStack {
                    Text("Refuel Cost")
                    Spacer()
                    TextField("", text: $refuelData.moneyString)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel(refuelData: .constant(Refuel.data[0].data))
    }
}
