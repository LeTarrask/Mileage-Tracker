//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @ObservedObject var tracker: MileageTracker

    @State private var newRefuelData = Refuel.Data()

    var body: some View {
        VStack {
            // MARK: - Refuels list
            List {
                ForEach(tracker.refuels.reversed(), id: \.self) { refuel in
                    RefuelCardView(refuel: refuel, average: tracker.averagePrice)
                }.onDelete(perform: removeItem)
                .animation(.easeInOut)
            }
            if !tracker.paidApp { Banner() }
        }.edgesIgnoringSafeArea(.all)
    }

    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        return view.preferredColorScheme(.dark)
    }
}
