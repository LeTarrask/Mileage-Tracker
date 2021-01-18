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
    let saveAction: () -> Void
    
    @State private var isPresented: Bool = false
    @State private var newRefuelData = Refuel.Data()
    
    var body: some View {
        VStack {
            
            // MARK: - Averages display
            ZStack {
                Color.blue
                    .frame(maxHeight: 140)
                    .cornerRadius(15)
                    .shadow(color: .black, radius: 3, x: 2, y: 1)
                VStack(alignment: .leading) {
                    Text("Total KM: \(tracker.totalKM.clean) km")
                    Text("Average consumption: \(tracker.averageConsumption) km/L")
                    Text("Average spending: \(tracker.averageSpending) km/€")
                    Text("Total fuel spending: \(tracker.totalSpending) €")
                    Text("Average Fuel Price: \(tracker.averagePrice) €/l")
                }
                .foregroundColor(.white)
            }.padding(15)
            
            // MARK: - other info views
            
            HStack {
                NavigationLink(
                    destination: GraphicsView(tracker: tracker),
                    label: {
                        Text("Graphics")
                    })
            }
            
            // MARK: - Refuels list
            List{
                ForEach(tracker.refuels, id: \.self) { refuel in
                    NavigationLink(
                        destination: RefuelDetail(refuel: refuel),
                        label: {
                            RefuelCardView(refuel: refuel)
                        })
                }.onDelete(perform: removeItem)
            }
        }
        .navigationBarTitle("Mileage Tracker", displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: { self.isPresented.toggle() },
                            label: { Image(systemName: "plus.circle") }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                AddRefuel(refuelData: $newRefuelData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Save") {
                        let newRefuel = Refuel(totalKM: newRefuelData.totalKM, liters: newRefuelData.liters, money: newRefuelData.money, kmAdded: newRefuelData.totalKM - tracker.totalKM)
                        tracker.refuels.append(newRefuel)
                        newRefuelData = Refuel.Data() // resets refuel data storage
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MileageView(tracker: MileageTracker(), saveAction: {})
        view.tracker.refuels = Refuel.data
        return view
    }
}



