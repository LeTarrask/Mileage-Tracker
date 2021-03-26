//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct MileageView: View {
    @ObservedObject var tracker: MileageTracker

    @Environment(\.scenePhase) private var scenePhase

    @State private var isPresented: Bool = false
    @State private var newRefuelData = Refuel.Data()

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Refuels list
                List {
                    ForEach(tracker.refuels.reversed(), id: \.self) { refuel in
                        RefuelCardView(refuel: refuel, average: tracker.averagePrice)
                    }.onDelete(perform: removeItem)
                }
                if !tracker.paidApp { Banner() }
            }
            .navigationBarTitle(NSLocalizedString("Mileage Tracker", comment: ""), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { self.isPresented.toggle() },
                                           label: { PlusButton() }))
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddRefuel(refuelData: $newRefuelData)
                        .navigationBarItems(leading: Button(NSLocalizedString("Dismiss", comment: "")) {
                            isPresented = false
                        }, trailing: Button(NSLocalizedString("Save", comment: "")) {
                            tracker.receiveNew(newRefuelData)
                            newRefuelData = Refuel.Data() // resets refuel data storage
                            isPresented = false
                        })
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { tracker.save() }
            }
        }
    }

    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView(tracker: MileageTracker())
        view.tracker.refuels = Refuel.data
        return view
    }
}
