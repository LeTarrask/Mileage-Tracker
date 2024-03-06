//
//  OtherCostsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @EnvironmentObject var tracker: MileageTracker
    @EnvironmentObject var settingsMG: SettingsManager

    @State private var newCostData = OtherCost.Data()

    var body: some View {
        VStack {
            if tracker.otherCosts.isEmpty {
                // MARK: Shows if there's no data
                LoadingView(headline: loadCostsHeadline,
                            paragraph: loadCostsParagraph)
            } else {
                VStack {
                    HStack(alignment: .top) {
                        Text(totalOtherLabel.uppercased())
                        Spacer()
                        Text(String(tracker.totalOtherCosts) + " ")
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

                    ScrollView {
                        ForEach(tracker.otherCosts.reversed()) { cost in
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
                //            if !tracker.paidApp { Banner() }
                .background(settingsMG.theme.secondColor)
            }
        }
    }
}

struct OtherCostsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherCostsView()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)
    }
}
