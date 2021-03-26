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

    var body: some View {
        VStack {
            Form {
                HStack {
                    Text(NSLocalizedString("Cost Name", comment: ""))
                    Spacer()
                    TextField("", text: $costData.name)
                        .keyboardType(.alphabet)
                }
                Picker(selection: $selection, label: Text(NSLocalizedString("Cost type", comment: ""))) {
                    ForEach(OtherCost.CostType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                HStack {
                    Text(NSLocalizedString("Cost Value", comment: ""))
                    Spacer()
                    TextField("", text: $costData.valueString)
                        .keyboardType(.decimalPad)
                }
            }.foregroundColor(themeMG.theme.mainColor)
            Button("Save") {
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
