//
//  CardView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 25/03/2021.
//

import SwiftUI

struct RefuelCardView: View {
    @StateObject var themeMG: ThemeManager = ThemeManager.shared
    
    var refuel: Refuel
    
    var average: Double
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text(refuelAtString + dateToString(date: refuel.creationDate))
                    .font(.caption)
                    .fontWeight(.light)

                HStack {
                    VStack(alignment: .leading) {
                        Image("bike")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(refuel.kmAdded.clean + " " + kmLabel)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(sinceLast)
                            .font(.caption)
                            .fontWeight(.light)
                        
                        Text(totalLabel + ": " + refuel.totalKM.clean + " " + kmLabel)
                            .font(.caption)
                            .fontWeight(.light)
                    }.padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Image("pump")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(refuel.liters.clean + " " + literLabel)
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(refuel.money.clean + euroLabel)
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(refuel.pricePerLiter.clean + " " + averageFuelPriceValue)
                            .font(.title)
                            .fontWeight(.bold)
                    }.padding()
                }
                .padding()
            }
            .foregroundColor(themeMG.theme.mainColor)
            .padding()
            .background(themeMG.theme.backgroundColor.cornerRadius(30))
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
