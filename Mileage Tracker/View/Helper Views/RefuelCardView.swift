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
    
    var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack {
            
            // New Cell
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(refuel.money.clean + euroLabel)
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(refuel.liters.clean + " " + literLabel)
                            .font(.callout)
                            .fontWeight(.bold)
                        
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        
                        Text(refuel.pricePerLiter.clean + " " + averageFuelPriceValue)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(dateToString(date: refuel.creationDate))
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(sinceLast)
                            .font(.caption)
                            .fontWeight(.light)
                        Text(refuel.kmAdded.clean + " " + kmLabel)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(totalLabel + ": " + refuel.totalKM.clean + " " + kmLabel)
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    
                }
                .foregroundColor(themeMG.theme.mainColor)
                .padding()
                .background(themeMG.theme.backgroundColor.cornerRadius(30))
            }
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
