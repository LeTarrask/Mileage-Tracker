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
    
    @EnvironmentObject var tracker: MileageTracker
    @EnvironmentObject var settingsMG: SettingsManager
    
    var body: some View {
        VStack {
            Text(addNewCost)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(settingsMG.theme.mainColor)

            Picker(typeOfCost, selection: $selection) {
                ForEach(CostType.allCases) { cost in
                    Text(cost.rawValue.capitalized)
                        .foregroundColor(settingsMG.theme.mainColor)
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
        }.background(settingsMG.theme.secondColor)
    }
}

struct AddObjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddObjectView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)
    }
}
