//
//  AddCostView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct AddCostView: View {
    @Binding var costData: OtherCost.Data

    @State var selection: OtherCost.CostType = .tax

    var body: some View {
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
                    // TO DO: have this selection update to costData.type
                }
            }
            HStack {
                Text(NSLocalizedString("Cost Value", comment: ""))
                Spacer()
                TextField("", text: $costData.valueString)
                    .keyboardType(.decimalPad)
            }
        }
    }
}

struct AddCostView_Previews: PreviewProvider {
    static var previews: some View {
        AddCostView(costData: .constant(OtherCost.data[0].data))
    }
}
