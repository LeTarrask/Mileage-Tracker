//
//  AddRefuel.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI
import Combine

struct AddRefuel: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker = MileageTracker.shared

    @State var refuelData = Refuel.Data()

    var body: some View {
        VStack {
            Form {
                Section(header: Text(addInfoLabel)) {
                    // MARK: - KM
                    HStack {
                        Text(kmLabel)
                        Spacer()
                        TextField("", text: $refuelData.kmString)
                            .keyboardType(.decimalPad)
                    }
                    // MARK: - Liters
                    HStack {
                        Text(literLabel)
                        Spacer()
                        TextField("", text: $refuelData.litersString)
                                .keyboardType(.decimalPad)
                    }
                    // MARK: - Cost
                    HStack {
                        Text(costLabel)
                        Spacer()
                        TextField("", text: $refuelData.moneyString)
                                .keyboardType(.decimalPad)
                    }
                }
                
                Button(saveLabel) {
                    tracker.receiveNew(refuelData)
                    tracker.save()
                    refuelData = Refuel.Data()
                }
            }.foregroundColor(themeMG.theme.mainColor)
        }
    }
}

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel()
    }
}
