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

    @ObservedObject var tracker: MileageTracker

    @State var refuelData = Refuel.Data()

    /// Localized strings
    private let addInfoLabel = NSLocalizedString("Add refuel info", comment: "")
    private let kmLabel = NSLocalizedString("Kilometers", comment: "")
    private let literLabel = NSLocalizedString("Liters", comment: "")
    private let costLabel = NSLocalizedString("Refuel Cost", comment: "")
    private let saveLabel = NSLocalizedString("Save", comment: "")

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
            }.foregroundColor(themeMG.theme.mainColor)

            Button(saveLabel) {
                tracker.receiveNew(refuelData)
                tracker.save()
                refuelData = Refuel.Data()
            }
            Spacer()
        }
    }
}

struct AddRefuel_Previews: PreviewProvider {
    static var previews: some View {
        AddRefuel(tracker: MileageTracker())
    }
}
