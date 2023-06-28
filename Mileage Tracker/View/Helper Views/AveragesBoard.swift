//
//  AveragesBoard.swift
//  Mileage Tracker
//
//  Created by tarrask on 08/02/2023.
//

import SwiftUI

struct AveragesBoard: View {
    @StateObject var settingsMG: SettingsManager = SettingsManager.shared
    
    @StateObject var tracker = MileageTracker.shared
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text(totalString)
                    .fontWeight(.black)
                    .foregroundColor(settingsMG.theme.mainColor)

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageConsumption.clean + " " + settingsMG.chosenDistance + "/" + settingsMG.chosenVolume)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(settingsMG.theme.mainColor)
                        Text(averageConsLabel)
                            .font(.caption2)
                            .foregroundColor(settingsMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(tracker.totalSpending.clean + " " + settingsMG.chosenCurrency)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(settingsMG.theme.mainColor)
                        Text(totalFuelSpendingLabel)
                            .font(.caption2)
                            .foregroundColor(settingsMG.theme.subtitleTextColor)
                    }
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageSpending.clean + " " + settingsMG.chosenDistance + "/" + settingsMG.chosenCurrency)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(settingsMG.theme.mainColor)
                        Text(averageSpenLabel)
                            .font(.caption2)
                            .foregroundColor(settingsMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(String(tracker.averagePrice) + " " + settingsMG.chosenCurrency + "/" + settingsMG.chosenVolume)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(settingsMG.theme.mainColor)
                        Text(averageFuelPriceLabel)
                            .font(.caption2)
                            .foregroundColor(settingsMG.theme.subtitleTextColor)
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            tracker.recalculateStats()
        }
        .padding()
        .background(settingsMG.theme.backgroundColor.cornerRadius(30))
        .padding()
    }
}

struct AveragesBoard_Previews: PreviewProvider {
    static var previews: some View {
        AveragesBoard(tracker: MileageTracker.shared)
    }
}
