//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @ObservedObject var tracker = MileageTracker.shared
    
    var body: some View {
        if tracker.refuels.isEmpty {
            // TO DO: add a top banner explaining what this app is about
            // TO DO: add an if to show refuels list if there are stored data, or instructions when it's empty
            Text("no items")
        } else {
            // MARK: - Refuels list
            List {
                ForEach(tracker.refuels.reversed(), id: \.self) { refuel in
                    RefuelCardView(refuel: refuel, average: tracker.averagePrice)
                }
                .onDelete(perform: removeItem)
                .animation(.easeInOut, value: 5)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView()
        view.tracker.paidApp = false
        // Generates fake data for preview
        view.tracker.refuels = Refuel.data
        return view// .preferredColorScheme(.dark)
    }
}
