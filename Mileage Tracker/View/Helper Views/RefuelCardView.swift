//
//  CardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    @EnvironmentObject var settingsMG: SettingsManager

    @EnvironmentObject var tracker: MileageTracker

    var refuel: Refuel

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(refuelAtString) +
                Text(dateToString(date: refuel.creationDate))
                    .foregroundColor(settingsMG.theme.mainColor.opacity(0.7))
            }
            .font(.title)
            .fontWeight(.bold)

            HStack {
                Image("bike")
                    .resizable()
                    .frame(width: 50, height: 50)

                Spacer()

                VStack(alignment: .leading) {
                    HStack {
                        Text(refuel.kmAdded.clean)
                            .fontWeight(.bold)
                        Text(" " + settingsMG.chosenDistance)
                    }

                    Text(sinceLast.uppercased())
                        .fontWeight(.light)
                }

                Spacer()

                VStack(alignment: .leading) {
                    HStack {
                        Text(refuel.totalKM.clean)
                            .fontWeight(.bold)
                        Text(" " + settingsMG.chosenDistance)
                    }

                    Text(totalLabel.uppercased())
                        .fontWeight(.light)


                }.foregroundColor(settingsMG.theme.mainColor).opacity(0.7)
            }


            HStack {
                Image("pump")
                    .resizable()
                    .frame(width: 50, height: 50)

                HStack {
                    Text(refuel.liters.clean)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: true, vertical: true)
                    Text(" " + settingsMG.chosenVolume)
                }

                Spacer()

                HStack {
                    Text(refuel.money.clean)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: true, vertical: true)
                    Text(" " + settingsMG.chosenCurrency)
                }

                Spacer()

                HStack {
                    Text(refuel.pricePerLiter.clean)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: true, vertical: true)
                    Text(" " + settingsMG.chosenCurrency + "/" + settingsMG.chosenVolume)

                    indicator
                }
            }
        }
        .foregroundColor(settingsMG.theme.mainColor)
        .padding(16)
        .background(settingsMG.theme.backgroundColor)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(settingsMG.theme.mainColor, lineWidth: 1)
        )
    }
    
    @ViewBuilder
    var indicator: some View {
        Image(systemName: "triangle.fill")
            .foregroundColor(refuel.pricePerLiter > tracker.averagePrice ? .red : .green)
            .rotationEffect(Angle(degrees: refuel.pricePerLiter > tracker.averagePrice ? 180 : 0))
    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        return ScrollView {
            RefuelCardView(refuel: tracker.refuels[0])

            RefuelCardView(refuel: tracker.refuels[1])

            RefuelCardView(refuel: tracker.refuels[2])
        }
        .environmentObject(MileageTracker.shared)
        .environmentObject(SettingsManager.shared)
    }
}
