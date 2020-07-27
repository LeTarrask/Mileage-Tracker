//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var tracker = MileageTracker()
    
    @State private var addRefuel: Bool = false
      
    var body: some View {
        NavigationView {
            VStack {
                
                // MARK: - Averages display
                VStack(alignment: .leading) {
                    Text("Average consumption: \(tracker.averageConsumption) km/L")
                    Text("Average spending: \(tracker.averageSpending) km/€")
                }.padding(.top, 15)
                
                // MARK: - Refuels list
                List{
                    ForEach(tracker.refuels, id: \.self) { refuel in
                        HStack {
                            Text(refuel.kmString)
                            Text(refuel.literString)
                            Text(refuel.moneyString)
                        }
                    }.onDelete(perform: removeItem)
                }
            }
            .navigationBarTitle("Mileage Tracker", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { self.addRefuel.toggle() }, label: {
                                        Image(systemName: "plus.circle")
                                    }))
            }.sheet(isPresented: $addRefuel) {
                AddRefuel(tracker: tracker)
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        tracker.refuels.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let tracker = MileageTracker()
        tracker.refuels = FakeData()
        return ContentView(tracker: tracker)
    }
}



