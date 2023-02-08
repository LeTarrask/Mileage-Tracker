//
//  AddCostView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct AddCostView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker = MileageTracker.shared

    @State var costData = OtherCost.Data()

    @State var selection: OtherCost.CostType = .tax

    var body: some View {
        VStack {
            Form {
                Section(header: Text(addCost)) {
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
                }
                
                Button(saveLabel) {
                    let newCost = OtherCost(type: costData.type,
                                            value: costData.value,
                                            name: costData.name)
                    tracker.otherCosts.append(newCost)
                    tracker.save()
                    costData = OtherCost.Data()
                }
            }.foregroundColor(themeMG.theme.mainColor)
        }
    }
}

struct AddCostView_Previews: PreviewProvider {
    static var previews: some View {
        AddCostView()
    }
}
