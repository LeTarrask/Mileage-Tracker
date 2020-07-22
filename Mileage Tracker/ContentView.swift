//
//  ContentView.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 22/07/2020.
//

import SwiftUI

struct ContentView: View {
    private var tracker = MileageTracker()
    
    @State private var addRefuel: Bool = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(tracker.refuels, id: \.self) { refuel in
                    Text(refuel.description)
                }
            }
            .navigationBarTitle("Mileage Tracker", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: { self.addRefuel.toggle() }, label: {
                                        Image(systemName: "plus.circle")
                                    }))
            }.sheet(isPresented: $addRefuel) {
                Text("add refuel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

