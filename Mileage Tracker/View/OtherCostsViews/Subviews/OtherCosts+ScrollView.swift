//
//  OtherCosts+ScrollView.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension OtherCostsView {
    @ViewBuilder
    func otherCostsScrollList() -> some View {
        ScrollView {
            ForEach(mileageVM.otherCosts.reversed()) { cost in
                HStack(alignment: .top) {
                    Image(systemName: cost.type == .tax ? "folder" : "wrench.fill")
                        .font(.largeTitle)

                    VStack(alignment: .leading) {
                        Text(cost.name)
                            .font(.headline)

                        Text(String(cost.value) + "" + valueLabel)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    Text(dateToString(date: cost.creationDate))
                        .font(.caption)
                }
                .foregroundColor(cost.type == .tax ?
                                 settingsMG.theme.backgroundColor : settingsMG.theme.mainColor)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(LinearGradient(gradient:
                                                cost.type == .tax ?
                                             settingsMG.theme.gradient1 :
                                                settingsMG.theme.gradient2,
                                             startPoint: .topLeading,
                                             endPoint: .bottomTrailing))
                        .frame(minHeight: 70, maxHeight: 80)
                )
            }
        }
        .padding(.horizontal)
    }
}
