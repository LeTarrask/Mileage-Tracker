//
//  OtherCostsView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 15/01/2021.
//

import SwiftUI

struct OtherCostsView: View {
    @StateObject var settingsMG: SettingsManager = SettingsManager.shared

    @StateObject var tracker = MileageTracker.shared

    @State private var newCostData = OtherCost.Data()

    var body: some View {
        VStack {
            if tracker.otherCosts.isEmpty {
                // MARK: Shows if there's no data
                LoadingView(headline: loadCostsHeadline, paragraph: loadCostsParagraph)
            } else {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(LinearGradient(gradient: settingsMG.theme.gradient1,
                                                 startPoint: .bottomLeading,
                                                 endPoint: .topTrailing))
                            .frame(minHeight: 70, maxHeight: 80)
                            .padding()

                        HStack {
                            Text(totalOtherLabel)
                            Text(String(tracker.totalOtherCosts) + " ")
                            Text(valueLabel)
                        }.foregroundColor(settingsMG.theme.backgroundColor)
                    }

                    ForEach(tracker.otherCosts.reversed()) { cost in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(LinearGradient(gradient:
                                                        cost.type == .tax ?
                                                        settingsMG.theme.gradient1 :
                                                        settingsMG.theme.gradient2,
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
                                                settingsMG.theme.backgroundColor : settingsMG.theme.mainColor)
                            .padding()
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
    }
}
