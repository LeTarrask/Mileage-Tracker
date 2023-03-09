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
            // MARK: - Loading screen when VM is empty
            Loading(headline: "Add your refuel info", paragraph: "Fill our tank with your refuel info and we'll create charts detailing how your bike's performing")
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
