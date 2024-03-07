//
//  CardView.swift
// Fuel Logue
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    @EnvironmentObject var settingsMG: SettingsManager

    @EnvironmentObject var mileageVM: MileageViewModel

    var refuel: Refuel

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(refuelAtString) +
                Text(dateToString(date: refuel.creationDate))
                    .foregroundColor(settingsMG.theme.mainColor.opacity(0.7))
            }
            .lineLimit(1)
            .font(.title)
            .fontWeight(.bold)

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
            .foregroundColor(refuel.pricePerLiter >= mileageVM.averagePrice ? .red : .green)
            .rotationEffect(Angle(degrees: refuel.pricePerLiter >= mileageVM.averagePrice ? 0 : 180))
    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let mileageVM = MileageViewModel.shared
        mileageVM.refuels = Refuel.data
        return ScrollView {
            RefuelCardView(refuel: mileageVM.refuels[0])

            RefuelCardView(refuel: mileageVM.refuels[1])

            RefuelCardView(refuel: mileageVM.refuels[2])
        }
        .environmentObject(MileageViewModel.shared)
        .environmentObject(SettingsManager.shared)
    }
}
