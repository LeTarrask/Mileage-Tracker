//
//  AveragesBoard.swift
//  Mileage Tracker
//
//  Created by tarrask on 08/02/2023.
//

import SwiftUI

struct AveragesBoard: View {
    @EnvironmentObject var settingsMG: SettingsManager

    @EnvironmentObject var tracker: MileageTracker

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(totalString)
                .fontWeight(.black)
                .foregroundColor(settingsMG.theme.mainColor)

            HStack {
                VStack(alignment: .leading) {
                    Text(
                        tracker.averageConsumption.clean 
                        + " " + settingsMG.chosenDistance
                        + "/" + settingsMG.chosenVolume
                    )
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(averageConsLabel)
                        .font(.subheadline)
                }
                .foregroundColor(settingsMG.theme.mainColor)

                Spacer()

                VStack(alignment: .leading) {
                    Text(tracker.totalSpending.clean + " " + settingsMG.chosenCurrency)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(totalFuelSpendingLabel)
                        .font(.subheadline)
                }
                .foregroundColor(settingsMG.theme.mainColor)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(
                        tracker.averageSpending.clean + " " 
                        + settingsMG.chosenDistance + "/"
                        + settingsMG.chosenCurrency
                    )
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(averageSpenLabel)
                        .font(.subheadline)
                }
                .foregroundColor(settingsMG.theme.mainColor)

                Spacer()

                VStack(alignment: .leading) {
                    Text(String(tracker.averagePrice) + " " + settingsMG.chosenCurrency + "/" + settingsMG.chosenVolume)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(averageFuelPriceLabel)
                        .font(.subheadline)
                }
                .foregroundColor(settingsMG.theme.mainColor)

            }
        }
        .onAppear {
            tracker.recalculateStats()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(settingsMG.theme.backgroundColor.cornerRadius(30))
        .padding()
    }
}

struct AveragesBoard_Previews: PreviewProvider {
    static var previews: some View {
        AveragesBoard()
            .environmentObject(MileageTracker.shared)
            .environmentObject(SettingsManager.shared)
    }
}
