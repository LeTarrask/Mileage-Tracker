//
//  OtherCosts+Header.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension OtherCostsView {
    @ViewBuilder
    func otherCostsHeader() -> some View {
        HStack(alignment: .top) {
            Text(totalOtherLabel.uppercased())
            Spacer()
            Text(String(mileageVM.totalOtherCosts) + " ")
            Text(valueLabel)
        }
        .font(.headline)
        .bold()
        .foregroundColor(settingsMG.theme.backgroundColor)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15.0)
                .fill(LinearGradient(gradient: settingsMG.theme.gradient1,
                                     startPoint: .topTrailing,
                                     endPoint: UnitPoint(x: 0.6, y: 0.7)))
        )
        .padding()
    }
}
