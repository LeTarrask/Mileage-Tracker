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
            // TODO: add a top banner explaining what this app is about
            // TODO: add an if to show refuels list if there are stored data, or instructions when it's empty
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

struct MileageView_Previews: PreviewProvider {
    static var previews: some View {
        MileageView()
    }
}
