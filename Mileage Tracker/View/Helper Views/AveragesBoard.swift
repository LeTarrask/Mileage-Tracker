//
//  AveragesBoard.swift
//  Mileage Tracker
//
//  Created by tarrask on 08/02/2023.
//

import SwiftUI

struct AveragesBoard: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    @ObservedObject var tracker = MileageTracker.shared
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text(totalString)
                    .fontWeight(.black)
                    .foregroundColor(themeMG.theme.mainColor)

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageConsumption.clean + " " + averageConsValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageConsLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(tracker.totalSpending.clean + " " + moneySymbol)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(totalFuelSpendingLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text(tracker.averageSpending.clean + " " + averageSpenValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageSpenLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }

                    VStack(alignment: .leading) {
                        Text(String(tracker.averagePrice) + " " + averageFuelPriceValue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(themeMG.theme.mainColor)
                        Text(averageFuelPriceLabel)
                            .font(.caption2)
                            .foregroundColor(themeMG.theme.subtitleTextColor)
                    }
                }
            }
            
            Spacer()
        }.padding()
        .background(themeMG.theme.backgroundColor.cornerRadius(30))
        .padding()
    }
}

struct AveragesBoard_Previews: PreviewProvider {
    static var previews: some View {
        AveragesBoard(tracker: MileageTracker())
    }
}
