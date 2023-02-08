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
    
    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView()
        view.tracker.refuels = Refuel.data
        view.tracker.paidApp = false
        return view// .preferredColorScheme(.dark)
    }
}
