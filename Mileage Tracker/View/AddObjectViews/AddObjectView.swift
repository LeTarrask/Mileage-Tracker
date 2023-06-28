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
    
    @ObservedObject var tracker: MileageTracker
    @ObservedObject var settingsMG: SettingsManager
    
    var body: some View {
        VStack {
            Text("Add new cost")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(settingsMG.theme.mainColor)

            Picker("Type of Cost", selection: $selection) {
                ForEach(CostType.allCases) { cost in
                    Text(cost.rawValue.capitalized)
                        .foregroundColor(settingsMG.theme.mainColor)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            switch selection {
            case .refuel:
                AddRefuel(tracker: tracker, settingsMG: settingsMG)
            case .other:
                AddCostView(tracker: tracker, settingsMG: settingsMG)
            }
        }.background(settingsMG.theme.secondColor)
    }
}

struct AddObjectView_Previews: PreviewProvider {
    static var previews: some View {
        AddObjectView(tracker: MileageTracker.shared, settingsMG: SettingsManager.shared)
    }
}
