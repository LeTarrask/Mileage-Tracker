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
    
    enum Field {
        case name, type, cost
    }
    
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            Form {
                Section(header: Text(addCost)) {
                    HStack {
                        Text(costName)
                        Spacer()
                        TextField("", text: $costData.name)
                            .keyboardType(.alphabet)
                            .focused($focusedField, equals: .name)
                            .submitLabel(.next)
                    }
                    Picker(selection: $selection, label: Text(costType)) {
                        ForEach(OtherCost.CostType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .focused($focusedField, equals: .type)
                                .submitLabel(.next)
                        }
                    }
                    HStack {
                        Text(costValue)
                        Spacer()
                        TextField("", text: $costData.valueString)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .cost)
                            .submitLabel(.done)
                    }
                }
                
                Button(saveLabel) {
                    saveCost()
                }
            }   .foregroundColor(themeMG.theme.mainColor)
                .onSubmit {
                    switch focusedField {
                    case .name:
                        focusedField = .type
                    case .type:
                        focusedField = .cost
                    case .cost:
                        focusedField = .none
                    case .none:
                        focusedField = nil
                    }
                }
        }
    }
    
    func saveCost() {
        let newCost = OtherCost(type: costData.type,
                                value: costData.value,
                                name: costData.name)
        tracker.otherCosts.append(newCost)
        tracker.save()
        costData = OtherCost.Data()
        hideKeyboard()
    }
}

struct AddCostView_Previews: PreviewProvider {
    static var previews: some View {
        AddCostView()
    }
}
