//
//  OtherCostsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared

    @ObservedObject var tracker: MileageTracker

    @State private var newCostData = OtherCost.Data()

    /// Label properties
    private let totalOtherLabel = NSLocalizedString("Total Other Costs: ", comment: "")
    private let valueLabel = NSLocalizedString("€", comment: "")

    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(LinearGradient(gradient: themeMG.theme.gradient1,
                                             startPoint: .bottomLeading,
                                             endPoint: .topTrailing))
                        .frame(minHeight: 70, maxHeight: 80)
                        .padding()

                    HStack {
                        Text(totalOtherLabel)
                        Text(String(tracker.totalOtherCosts) + " ")
                        Text(valueLabel)
                    }.foregroundColor(themeMG.theme.backgroundColor)
                }
                ForEach(tracker.otherCosts.reversed()) { cost in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(LinearGradient(gradient:
                                                    cost.type == .tax ?
                                                    themeMG.theme.gradient1 :
                                                    themeMG.theme.gradient2,
                                                 startPoint: .topLeading,
                                                 endPoint: .bottomTrailing))
                            .frame(minHeight: 70, maxHeight: 80)
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: cost.type == .tax ? "folder" : "wrench.fill")
                                    Text(String(cost.value) + "" + valueLabel)
                                        .fontWeight(.bold)
                                }
                                Text(cost.name)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text(dateToString(date: cost.creationDate))
                                .font(.caption)
                        }
                        .foregroundColor(cost.type == .tax ?
                                            themeMG.theme.backgroundColor : themeMG.theme.mainColor)
                        .padding()
                    }
                }.padding(.horizontal)
            }
            if !tracker.paidApp { Banner() }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct OtherCostsView_Previews: PreviewProvider {
    static var previews: some View {
        let view = OtherCostsView(tracker: MileageTracker())
        view.tracker.otherCosts = OtherCost.data
        return view
    }
}
