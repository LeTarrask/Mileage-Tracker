//
//  CardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    @ObservedObject var tracker = MileageTracker.shared
    
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
                            Text(" " + kmLabel)
                        }
                            
                        Text(sinceLast)
                            .font(.caption)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        Group {
                            HStack {
                                Text(refuel.totalKM.clean)
                                    .fontWeight(.bold)
                                Text(" " + kmLabel)
                            }
                            
                            Text(totalLabel)
                                .font(.caption)
                                .fontWeight(.light)
                        }.foregroundColor(themeMG.theme.highlightColor)
                    }.padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Image("pump")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        HStack {
                            Text(refuel.liters.clean)
                                .fontWeight(.bold)
                            Text(" " + literLabel)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text(refuel.money.clean)
                                .fontWeight(.bold)
                            Text(" " + euroLabel)
                        }.foregroundColor(themeMG.theme.highlightColor)
                        
                        Spacer()
                           
                        HStack {
                            Text(refuel.pricePerLiter.clean)
                                .fontWeight(.bold)
                            Text(" " + averageFuelPriceValue)
                            
                            indicator
                        }
                    }.padding()
                }
                .padding()
            }
            .foregroundColor(themeMG.theme.mainColor)
            .padding()
            .background(themeMG.theme.backgroundColor.cornerRadius(30))
        }
    }
    
    @ViewBuilder
    var indicator: some View {
        if refuel.pricePerLiter > tracker.averagePrice {
            Image(systemName: "triangle.fill")
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 180))// price paid was more than average
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
    }
}
