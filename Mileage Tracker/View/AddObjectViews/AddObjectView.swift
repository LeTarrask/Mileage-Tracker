//
//  AddObjectView.swift
//  Mileage Tracker
//
//  Created by tarrask on 07/03/2023.
//

import SwiftUI

struct AddObjectView: View {
    enum CostType: String, CaseIterable, Identifiable {
        case refuel, other
        var id: Self { self }
    }
    
    @State private var selection: CostType = .refuel
    
    var body: some View {
        VStack {
            Picker("Type of Cost", selection: $selection) {
                ForEach(CostType.allCases) { cost in
                    Text(cost.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selection {
            case .refuel:
                AddRefuel()
            case .other:
                AddCostView()
            }
        }
    }
}

struct AddObjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddObjectView()
    }
}