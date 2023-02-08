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
    
    /// Localizable strings
    let sinceLast = NSLocalizedString("Since last", comment: "")
    let kmLabel = NSLocalizedString("km", comment: "")
    let literLabel = NSLocalizedString("L", comment: "")
    let fuelLabel = NSLocalizedString("Fuel", comment: "")
    let euroLabel = NSLocalizedString("€", comment: "")
    let paymentLabel = NSLocalizedString("Payment", comment: "")
    let thanAverageLabel = NSLocalizedString("than average:", comment: "")
    let perLiter = NSLocalizedString("per liter:", comment: "")
    let totalLabel = NSLocalizedString("Total", comment: "")
    let refuelAtLabel = NSLocalizedString("Refuel at: ", comment: "")
    
    var body: some View {
        VStack {
            
            /// New Cell
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
                        
                        Text(refuel.pricePerLiter.clean + " €/L")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(dateToString(date: refuel.creationDate))
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Since last: ")
                            .font(.caption)
                            .fontWeight(.light)
                        Text(refuel.kmAdded.clean + " " + kmLabel)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Total: " + refuel.totalKM.clean + " " + kmLabel)
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
