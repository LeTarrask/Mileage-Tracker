//
//  MileageView+RefuelList.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension MileageView {
    // MARK: - Refuels list
    @ViewBuilder
    func refuelsList() -> some View {
        ZStack {
            settingsMG.theme.backgroundColor

            List {
                ForEach(mileageVM.refuels.reversed(), id: \.self) { refuel in
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

    func removeItem(at offsets: IndexSet) {
        mileageVM.refuels.remove(atOffsets: offsets)
    }
}
