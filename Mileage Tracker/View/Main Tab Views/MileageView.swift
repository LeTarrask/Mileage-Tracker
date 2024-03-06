//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @EnvironmentObject var tracker: MileageTracker
    @EnvironmentObject var settingsMG: SettingsManager
    
    var body: some View {
        if tracker.refuels.isEmpty {
            // MARK: - Loading screen when VM is empty
            LoadingView(headline: loadRefuelsHeadline, paragraph: loadRefuelParagraph, image: "fuelpump")
        } else {
            // MARK: - Refuels list
            ZStack {
                settingsMG.theme.backgroundColor
                
                List {
                    ForEach(tracker.refuels.reversed(), id: \.self) { refuel in
                        RefuelCardView(refuel: refuel)
                            .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: removeItem)
                    .animation(.easeInOut, value: 5)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(settingsMG.theme.secondColor)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct MileageView_Previews: PreviewProvider {
    static var previews: some View {
        MileageView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)

        MileageView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE (3rd generation)")
    }
}
