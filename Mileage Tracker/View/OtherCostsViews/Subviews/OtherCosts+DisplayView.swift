//
//  OtherCosts+DataView.swift
//  Fuel Logue
//
//  Created by Alex Luna on 06/03/2024.
//

import SwiftUI

extension OtherCostsView {
    @ViewBuilder
    func otherCostDisplay() -> some View {
        VStack {
            otherCostsHeader()

            otherCostsScrollList()
        }
        //            if !mileageVM.paidApp { Banner() }
    }
}
