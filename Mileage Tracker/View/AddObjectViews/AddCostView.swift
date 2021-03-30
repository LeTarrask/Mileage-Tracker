//
//  AddCostView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct AddCostView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker: MileageTracker

    @State var costData = OtherCost.Data()

    @State var selection: OtherCost.CostType = .tax

    /// Localized strings
    private let costName = NSLocalizedString("Cost Name", comment: "")
    private let costType = NSLocalizedString("Cost type", comment: "")
    private let costValue = NSLocalizedString("Cost Value", comment: "")
    private let saveLabel = NSLocalizedString("Save", comment: "")

    var body: some View {
        VStack {
            Form {
                HStack {
                    Text(costName)
                    Spacer()
                    TextField("", text: $costData.name)
                        .keyboardType(.alphabet)
                }
                Picker(selection: $selection, label: Text(costType)) {
                    ForEach(OtherCost.CostType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                HStack {
                    Text(costValue)
                    Spacer()
                    TextField("", text: $costData.valueString)
                        .keyboardType(.decimalPad)
                }
            }.foregroundColor(themeMG.theme.mainColor)
            Button(saveLabel) {
                let newCost = OtherCost(type: costData.type,
                                        value: costData.value,
                                        name: costData.name)
                tracker.otherCosts.append(newCost)
                tracker.save()
                costData = OtherCost.Data()
            }
        }
    }
}

struct AddCostView_Previews: PreviewProvider {
    static var previews: some View {
        AddCostView(tracker: MileageTracker())
    }
}
