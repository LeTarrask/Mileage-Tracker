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
    
    var average: Double
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Group {
                    Text(refuelAtString).fontWeight(.bold) +
                    Text(dateToString(date: refuel.creationDate)).fontWeight(.light)
                }.font(.caption)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Image("bike")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        HStack {
                            Text(refuel.kmAdded.clean)
                                .fontWeight(.bold)
                            Text(" " + settingsMG.chosenDistance)
                        }
                        
                        Text(sinceLast)
                            .font(.caption)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Group {
                            HStack {
                                Text(refuel.totalKM.clean)
                                    .fontWeight(.bold)
                                Text(" " + settingsMG.chosenDistance)
                            }
                            
                            Text(totalLabel)
                                .font(.caption)
                                .fontWeight(.light)
                        }.foregroundColor(settingsMG.theme.highlightColor)
                    }.padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Image("pump")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        HStack {
                            Text(refuel.liters.clean)
                                .fontWeight(.bold)
                            Text(" " + settingsMG.chosenVolume)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text(refuel.money.clean)
                                .fontWeight(.bold)
                            Text(" " + settingsMG.chosenCurrency)
                        }.foregroundColor(settingsMG.theme.highlightColor)
                        
                        Spacer()
                        
                        HStack {
                            Text(refuel.pricePerLiter.clean)
                                .fontWeight(.bold)
                            Text(" " + settingsMG.chosenCurrency + "/" + settingsMG.chosenVolume)
                            
                            indicator
                        }
                    }.padding()
                }
                .padding()
            }
            .foregroundColor(settingsMG.theme.mainColor)
            .padding()
            .background(settingsMG.theme.backgroundColor.cornerRadius(30))
        }
        .background(settingsMG.theme.secondColor)
    }
    
    @ViewBuilder
    var indicator: some View {
        if refuel.pricePerLiter > tracker.averagePrice {
            Image(systemName: "triangle.fill")
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 180)) // price paid was more than average
        } else {
            Image(systemName: "triangle.fill")
                .foregroundColor(.green) // price paid was less than average
        }
    }
}

struct RefuelCardView_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.refuels = Refuel.data
        return RefuelCardView(refuel: tracker.refuels[0],
                              average: tracker.averagePrice)
                .environmentObject(MileageTracker.shared)
                .environmentObject(SettingsManager.shared)
    }
}
